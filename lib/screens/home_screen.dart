import 'dart:async';
import 'package:fix_map/blocs/blocs.dart';
import 'package:fix_map/generated/i18n.dart';
import 'package:fix_map/models/models.dart';
import 'package:fix_map/utils/utils.dart';
import 'package:fix_map/widgets/shop_card.dart';
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
  ScrollController _scrollController;
  Completer<GoogleMapController> _controller = Completer();
  // ignore: close_sinks
  SettingsBloc settingsBloc;
  // ignore: close_sinks
  MapBloc mapBloc;
  final Set<Marker> _marker = {};

  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(10.755639, 106.134703),
    zoom: 14.4746,
  );

  @override
  void initState() {
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);
    _scrollController = ScrollController();
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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
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
                mapBloc.add(MapFetchShopsEvent());
              }
            },
            child: BlocBuilder<MapBloc, MapState>(
              bloc: mapBloc,
              builder: (context, state) {
                var style = mapStyleLight;
                if (settingsBloc.settings.darkMode) {
                  style = mapStyleDark;
                }
                List<Shop> shops = [];
                if (state is MapDataUpdatedState) {
                  shops = mapBloc.shops;
                  for (int index = 0; index < shops.length; index++) {
                    var shop = shops[index];
                    if (shop.longitude != null && shop.longitude != null) {
                      _marker.add(Marker(
                          markerId: MarkerId(shop.phoneNumber + shop.address),
                          position: LatLng(shop.latitude, shop.longitude),
                          onTap: () {
                            _scrollController.animateTo(
                                (_scrollController.position.maxScrollExtent /
                                        shops.length) *
                                    (index + 1),
                                duration: Duration(seconds: 1),
                                curve: Curves.easeOut);
                          },
                          infoWindow: InfoWindow(title: shop.name)));
                    }
                  }
                }
                return Stack(
                  children: <Widget>[
                    GoogleMap(
                      initialCameraPosition: _cameraPosition,
                      mapType: MapType.normal,
                      markers: _marker,
                      myLocationEnabled: true,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.085,
                        bottom: MediaQuery.of(context).size.height * 0.3,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                        _controller.future.then(
                            (controller) => controller.setMapStyle(style));
                      },
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        height: MediaQuery.of(context).size.height * 0.085,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.search),
                                  border: InputBorder.none,
                                  hintText: S.of(context).searchHintText),
                            ),
                          ),
                        ),
                      ),
                    ),
                    shops.isNotEmpty
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: ListView.builder(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: shops.length,
                                itemBuilder: (context, index) {
                                  return ShopCard(
                                    shop: shops[index],
                                    onPressed: () async {
                                      await _controller.future.then(
                                          (controller) =>
                                              controller.animateCamera(
                                                  CameraUpdate.newLatLng(LatLng(
                                                      shops[index].latitude,
                                                      shops[index]
                                                          .longitude))));
                                    },
                                  );
                                },
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
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
