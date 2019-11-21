import 'dart:async';
import 'package:fix_map/blocs/blocs.dart';
import 'package:fix_map/blocs/shops/bloc.dart';
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
  Set<Marker> _markers = {};
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(10.755639, 106.134703),
    zoom: 16,
  );

  @override
  void initState() {
    _scrollController = ScrollController();
    BlocProvider.of<SettingsBloc>(context)
        .add(SettingsRequestPermissionEvent());
    MarkerUtils.initIcons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocListener<SettingsBloc, SettingsState>(
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
            _showRequestPermissionDialog();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: HomeDrawer(),
          body: MultiBlocListener(
            listeners: [
              BlocListener<MapBloc, MapState>(
                listener: (context, state) async {
                  if (state is MapCurrentLocationUpdatedState) {
                    await _controller.future.then((controller) =>
                        controller.animateCamera(CameraUpdate.newLatLng(LatLng(
                            state.position.latitude,
                            state.position.longitude))));
                  }
                },
              ),
              BlocListener<ShopsBloc, ShopsState>(
                listener: (context, state) async {
                  if (state is ShopsLoadingState) {
                    _refreshIndicatorKey.currentState.show();
                  }
                },
              ),
            ],
            child: BlocBuilder<ShopsBloc, ShopsState>(
              builder: (context, state) {
                List<Shop> shops = [];
                shops = BlocProvider.of<ShopsBloc>(context).shops;
                if (state is ShopsLoadedState) {
                  _markers.clear();
                  for (int index = 0; index < shops.length; index++) {
                    var shop = shops[index];
                    _markers.add(Marker(
                        markerId: MarkerId(shop.hash),
                        position: LatLng(shop.latitude, shop.longitude),
                        icon: shop.address.isEmpty
                            ? BitmapDescriptor.fromBytes(MarkerUtils.circle)
                            : null,
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
                double mapPaddingBottom = 0.0;
                if (shops.isNotEmpty) {
                  mapPaddingBottom = MediaQuery.of(context).size.height * 0.3;
                }
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () async {
                    var controller = await _controller.future;
                    var bounds = await controller.getVisibleRegion();
                    BlocProvider.of<ShopsBloc>(context)
                        .add(ShopsSearchEvent(bounds));
                    await Future.delayed(Duration(seconds: 1));
                  },
                  child: Stack(
                    children: <Widget>[
                      GoogleMap(
                        initialCameraPosition: _cameraPosition,
                        markers: _markers,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        compassEnabled: true,
                        onCameraIdle: () {
                          BlocProvider.of<ShopsBloc>(context)
                              .add(ShopsLoadingEvent());
                        },
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.08,
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
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: shops.length,
                                  itemBuilder: (context, index) {
                                    if (shops[index].name.isEmpty) {
                                      return Container();
                                    }
                                    return ShopCard(
                                      shop: shops[index],
                                      onPressed: () async {
                                        await _controller.future.then(
                                            (controller) => controller
                                                .animateCamera(
                                                    CameraUpdate.newLatLng(
                                                        LatLng(
                                                            shops[index]
                                                                .latitude,
                                                            shops[index]
                                                                .longitude))));
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
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
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

  Widget _buildAction() {
    return Builder(builder: (context) {
      return IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {},
      );
    });
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
              BlocProvider.of<SettingsBloc>(context)
                  .add(SettingsRequestPermissionEvent());
            },
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    var style = mapStyleLight;
    if (BlocProvider.of<SettingsBloc>(context).settings.darkMode) {
      style = mapStyleDark;
    }
    _controller.future.then((controller) => controller.setMapStyle(style));
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
