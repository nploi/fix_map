import 'dart:async';
import 'package:fix_map/blocs/blocs.dart';
import 'package:fix_map/generated/i18n.dart';
import 'package:fix_map/utils/utils.dart';
import 'package:fix_map/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "home";
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentBackPressTime;
  Completer<GoogleMapController> _controller = Completer();
  // ignore: close_sinks
  SettingsBloc settingsBloc;
  // ignore: close_sinks
  MapBloc mapBloc;

  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(10.755639, 106.134703),
    zoom: 14.4746,
  );

  @override
  void initState() {
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);
    settingsBloc.add(SettingsRequestPermissionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocListener<SettingsBloc, SettingsState>(
        bloc: settingsBloc,
        listener: (context, state) async {
          var mapStyle = mapStyleLight;
          if (state is SettingsUpdatedSettingsState) {
            if (state.settings.darkMode) {
              mapStyle = mapStyleDark;
            }
            await _controller.future
                .then((controller) => controller.setMapStyle(mapStyle));
          }

          if (state is SettingsGrantedPermissionState) {
            mapBloc.add(MapCurrentLocationGetEvent());
          }

          if (state is SettingsNotGrantedPermissionState) {
            _showRequestPermissionDialog();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            bottomOpacity: 0.1,
          ),
          drawer: HomeDrawer(
            settingsBloc: settingsBloc,
          ),
          body: BlocListener<MapBloc, MapState>(
            bloc: mapBloc,
            listener: (context, state) async {
              if (state is MapCurrentLocationUpdatedState) {
                await _controller.future.then((controller) =>
                    controller.animateCamera(CameraUpdate.newLatLng(LatLng(
                        state.position.latitude, state.position.longitude))));
              }
            },
            child: BlocBuilder<MapBloc, MapState>(
              bloc: mapBloc,
              builder: (context, state) {
                var style = mapStyleLight;
                if (settingsBloc.settings.darkMode) {
                  style = mapStyleDark;
                }
                return GoogleMap(
                  initialCameraPosition: _cameraPosition,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    _controller.future
                        .then((controller) => controller.setMapStyle(style));
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showRequestPermissionDialog() {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(S.of(context).requestPermissionDialogTitle),
        content: Text(S.of(context).requestPermissionDialogContent),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(S.of(context).doNotAllowLabelButton),
            onPressed: () =>
                Navigator.pop(context, S.of(context).doNotAllowLabelButton),
          ),
          CupertinoDialogAction(
            child: Text(S.of(context).allowLabelButton),
            onPressed: () {
              settingsBloc.add(SettingsRequestPermissionEvent());
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: S.of(context).backAgainToLeaveMessage);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
