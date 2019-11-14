import 'dart:async';
import 'package:fix_map/blocs/blocs.dart';
import 'package:fix_map/utils/utils.dart';
import 'package:fix_map/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "home";
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  // ignore: close_sinks
  SettingsBloc settingsBloc;
  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
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
      },
      child: Scaffold(
        appBar: AppBar(),
        drawer: HomeDrawer(
          settingsBloc: settingsBloc,
        ),
        body: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            var style = mapStyleLight;
            if (settingsBloc.settings.darkMode) {
              style = mapStyleDark;
            }
            return GoogleMap(
              initialCameraPosition: _cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                _controller.future
                    .then((controller) => controller.setMapStyle(style));
              },
            );
          },
        ),
      ),
    );
  }
}
