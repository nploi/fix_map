import 'dart:async';
import 'package:fix_map/blocs/blocs.dart';
import 'package:fix_map/blocs/shops/bloc.dart';
import 'package:fix_map/dialogs/dialogs.dart';
import 'package:fix_map/generated/i18n.dart';
import 'package:fix_map/models/models.dart';
import 'package:fix_map/screens/screens.dart';
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
  Map<String, Marker> _markers = {};
  int lastIndex = -1;
  bool isFirst = false;
  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(10.755639, 106.134703),
    zoom: 16,
  );

  LatLng center;
  double zoom = 16;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      var index = _scrollController.position.pixels ~/
          (MediaQuery.of(context).size.width * 0.45);
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        index = BlocProvider.of<ShopsBloc>(context).shops.length - 1;
      }
      if (index != lastIndex) {
        print("change");
        lastIndex = index;
        onShopChange(index, BlocProvider.of<ShopsBloc>(context).shops);
      }
    });
    BlocProvider.of<ShopsBloc>(context).add(ShopsCheckDataEvent());
    MarkerUtils.initIcons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: HomeDrawer(),
        body: MultiBlocListener(
          listeners: [
            BlocListener<MapBloc, MapState>(
              listener: (context, state) async {
                if (state is MapCurrentLocationUpdatedState) {
                  await _controller.future.then(
                    (controller) => controller.animateCamera(
                        CameraUpdate.newLatLngZoom(
                            LatLng(state.position.latitude,
                                state.position.longitude),
                            16)),
                  );
                }
              },
            ),
            BlocListener<ShopsBloc, ShopsState>(
              listener: (context, state) async {
                if (state is ShopsDataNotFoundState) {
                  BlocProvider.of<ShopsBloc>(context).add(ShopsDownLoadEvent());
                  showDownloadDialog(
                      this.context, BlocProvider.of<ShopsBloc>(context));
                }

                if (state is ShopsDownloadedState) {
                  BlocProvider.of<SettingsBloc>(context)
                      .add(SettingsRequestPermissionEvent());
                }
              },
            ),
            BlocListener<SettingsBloc, SettingsState>(
              listener: (context, state) async {
                if (state is SettingsUpdatedSettingsState) {
                  var mapStyle = mapStyleLight;

                  if (state.settings.darkMode) {
                    mapStyle = mapStyleDark;
                  }

                  await _controller.future
                      .then((controller) => controller.setMapStyle(mapStyle));
                }

                if (state is SettingsNotGrantedPermissionState) {
                  showRequestPermissionDialog(this.context);
                }
              },
            ),
          ],
          child: BlocBuilder<ShopsBloc, ShopsState>(
            builder: (context, state) {
              bool isLoading = false;
              if (state is ShopsLoadingState) {
                isLoading = true;
              }
              List<Shop> shops = BlocProvider.of<ShopsBloc>(context).shops;
              if (state is ShopsLoadedState) {
                for (int index = 0; index < shops.length; index++) {
                  var shop = shops[index];
                  _markers[shop.hash] = Marker(
                    markerId: MarkerId(shop.hash),
                    position: LatLng(shop.latitude, shop.longitude),
                    icon:
                        BitmapDescriptor.fromBytes(MarkerUtils.settingsCircle),
                    onTap: () {
                      String currentMarkerId =
                          BlocProvider.of<MapBloc>(context).currentMarkerId;
                      if (_markers.containsKey(currentMarkerId)) {
                        _markers[currentMarkerId] =
                            _markers[currentMarkerId].copyWith(
                          iconParam: BitmapDescriptor.fromBytes(
                              MarkerUtils.settingsCircle),
                        );
                      }
                      BlocProvider.of<MapBloc>(context)
                          .add(MapMarkerPressedEvent(shop.hash));
//                        _scrollController.animateTo(
//                            (_scrollController.position.maxScrollExtent /
//                                    shops.length) *
//                                (index + 1),
//                            duration: Duration(seconds: 1),
//                            curve: Curves.easeOut);
                    },
                  );
                }

                LatLngBounds bounds;
                if (center != null) {
                  bounds = MapUtils.toBounds(center, MapUtils.RADIUS);
                  _markers.entries.forEach((entry) {
                    if (!bounds.contains(entry.value.position)) {
                      _markers[entry.key] =
                          _markers[entry.key].copyWith(visibleParam: false);
                    }
                  });
                }
              }

              double mapPaddingBottom = 0.0;

              if (shops.isNotEmpty) {
                mapPaddingBottom = MediaQuery.of(context).size.height * 0.3;
              }

              return BlocBuilder<MapBloc, MapState>(
                builder: (context, mapState) {
                  if (mapState is MapMarkerPressedState) {
                    _markers[mapState.markerId] =
                        _markers[mapState.markerId].copyWith(
                      iconParam: BitmapDescriptor.fromBytes(
                          MarkerUtils.settingsLocation),
                    );
                  }
                  return Stack(
                    children: <Widget>[
                      GoogleMap(
                        initialCameraPosition: _cameraPosition,
                        markers: Set<Marker>.from(_markers.values),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        mapToolbarEnabled: false,
                        compassEnabled: true,
                        onCameraIdle: () {
                          if (!isFirst) {
                            isFirst = true;
                            _refresh();
                          } else {
                            BlocProvider.of<ShopsBloc>(context)
                                .add(ShopsCanRefreshEvent());
                          }
                        },
                        onCameraMove: (CameraPosition camera) {
                          zoom = camera.zoom;
                          if (camera.zoom < 16) {
                            center = camera.target;
                          } else {
                            center = null;
                          }
                        },
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1,
                          bottom: mapPaddingBottom,
                        ),
                        onMapCreated: _onMapCreated,
                      ),
                      shops.isNotEmpty
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  controller: _scrollController,
                                  itemCount: shops.length,
                                  itemBuilder: (context, index) {
                                    if (shops[index].name.isEmpty) {
                                      return Container();
                                    }
                                    return ShopCard(
                                      shop: shops[index],
                                      onPressed: () {
                                        Navigator.pushNamed(this.context,
                                            ShopDetailScreen.routeName,
                                            arguments: shops[index]);
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          : SizedBox(),
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 5,
                        left: 5,
                        child: _buildMenuButton(),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 5,
                        right: 5,
                        child: _buildAction(),
                      ),
                      isLoading
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 3,
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).padding.top),
                                child: LinearProgressIndicator(),
                              ),
                            )
                          : SizedBox(),
                      AnimatedPositioned(
                        bottom: mapPaddingBottom +
                            ((state is ShopsCanRefreshState) ? 45 : 5),
                        right: 10,
                        child: _buildRefreshButton(),
                        duration: Duration(milliseconds: 200),
                      ),
                      Positioned(
                        bottom: mapPaddingBottom + 5,
                        right: 10,
                        child: _buildMyLocation(),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void onShopChange(int index, shops) {
    String currentMarkerId = BlocProvider.of<MapBloc>(context).currentMarkerId;
    if (_markers.containsKey(currentMarkerId)) {
      _markers[currentMarkerId] = _markers[currentMarkerId].copyWith(
        iconParam: BitmapDescriptor.fromBytes(MarkerUtils.settingsCircle),
      );
    }
    BlocProvider.of<MapBloc>(context)
        .add(MapMarkerPressedEvent(shops[index].hash));
    _controller.future.then((controller) => controller.animateCamera(
        CameraUpdate.newLatLng(
            LatLng(shops[index].latitude, shops[index].longitude))));
  }

  Widget _buildMenuButton() {
    return Builder(builder: (context) {
      return IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    });
  }

  Widget _buildMyLocation() {
    return SizedBox(
      height: Theme.of(context).iconTheme.size * 1.5,
      width: Theme.of(context).iconTheme.size * 1.5,
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          BlocProvider.of<MapBloc>(context).add(MapGetCurrentLocationEvent());
        },
        child: Icon(Icons.my_location),
      ),
    );
  }

  Widget _buildRefreshButton() {
    return SizedBox(
      height: Theme.of(context).iconTheme.size * 1.5,
      width: Theme.of(context).iconTheme.size * 1.5,
      child: FloatingActionButton(
        onPressed: _refresh,
        heroTag: null,
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildAction() {
    return Builder(builder: (context) {
      return IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {},
      );
    });
  }

  Future _refresh({LatLng latLng}) async {
    if (!(BlocProvider.of<ShopsBloc>(context).state is ShopsLoadingState)) {
      LatLngBounds bounds;
      if (center != null) {
        bounds = MapUtils.toBounds(center, MapUtils.RADIUS);
      } else if (latLng == null) {
        var controller = await _controller.future;
        bounds = await controller.getVisibleRegion();
      } else {
        bounds = MapUtils.toBounds(latLng, MapUtils.RADIUS);
      }
      BlocProvider.of<ShopsBloc>(context).add(ShopsSearchEvent(bounds));
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
      var style = mapStyleLight;
      if (BlocProvider.of<SettingsBloc>(context).settings.darkMode) {
        style = mapStyleDark;
      }
      _controller.future.then((controller) => controller.setMapStyle(style));
    }
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

  @override
  void dispose() {
    super.dispose();
  }
}
