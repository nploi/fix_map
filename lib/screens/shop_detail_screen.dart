import "package:cached_network_image/cached_network_image.dart";
import "package:fix_map/blocs/blocs.dart";
import "package:fix_map/generated/i18n.dart";
import "package:fix_map/models/models.dart";
import "package:fix_map/screens/review_screen.dart";
import 'package:fix_map/screens/screens.dart';
import "package:fix_map/widgets/widgets.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:url_launcher/url_launcher.dart";

class ShopDetailScreen extends StatefulWidget {
  static final String routeName = "/shop_detail";
  final Shop shop;

  const ShopDetailScreen({Key key, this.shop}) : super(key: key);

  @override
  _ShopDetailScreenState createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  ShopDetailBloc _bloc;
  FeedbackBloc _feedbackBloc;
  AuthenticationBloc _authenticationBloc;

  Shop shop = Shop();

  @override
  void initState() {
    super.initState();
    _bloc = ShopDetailBloc()..add(ShopDetailByHashEvent(widget.shop.hash));
    _feedbackBloc = FeedbackBloc()
      ..add(FeedbackGetListFeedbackEvent(widget.shop.hash));
    _authenticationBloc = AuthenticationBloc();
    shop = widget.shop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<FeedbackBloc, FeedbackState>(
      bloc: _feedbackBloc,
      listener: (context, state) {
        if (state is FeedbackAddedFeedbackState) {
          _bloc.add(ShopDetailByHashEvent(widget.shop.hash));
          _feedbackBloc.add(FeedbackGetListFeedbackEvent(widget.shop.hash));
        }
      },
      child: BlocBuilder<ShopDetailBloc, ShopDetailState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is ShopDetailFoundState) {
              shop = state.shop;
            }
            return BlocBuilder<FeedbackBloc, FeedbackState>(
              bloc: _feedbackBloc,
              builder: (BuildContext context, FeedbackState state) {
                final List<Widget> widgets = [];
                if (state is FeedbackLoadedListFeedbackState) {
                  state.listFeedback
                      .forEach((feedback) => widgets.add(Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).dividerColor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: ListTile(
                              leading: Icon(Icons.account_circle),
                              title: Text("Anonymous"),
                              subtitle: Text(feedback.comment),
                            ),
                          )));
                }
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * 0.3,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Hero(
                          tag: widget.shop.name + "-" + widget.shop.address,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                              imageUrl: widget.shop.imageBig,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        collapseMode: CollapseMode.pin,
                        title: Text(widget.shop.name),
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: SliverAppBarDelegate(
                        minHeight: 60.0,
                        maxHeight: 60.0,
                        child: ListTile(
                          title: Text(widget.shop.address),
                          trailing: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: FloatingActionButton(
                              heroTag: null,
                              child: Icon(Icons.directions),
                              onPressed: () async {
                                final url =
                                    "https://www.google.com/maps/dir/Current+Location/${widget.shop.latitude},${widget.shop.longitude}";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    widget.shop.phoneNumber.isNotEmpty
                        ? SliverPersistentHeader(
                            delegate: SliverAppBarDelegate(
                              minHeight: 60.0,
                              maxHeight: 60.0,
                              child: ListTile(
                                title: Text(widget.shop.phoneNumber),
                                trailing: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: FloatingActionButton(
                                    heroTag: null,
                                    child: Icon(Icons.call),
                                    onPressed: () async {
                                      final items =
                                          widget.shop.phoneNumber.split(";");
                                      if (items.length > 1) {
                                        _selectPhoneModalBottomSheet(
                                            context, items);
                                        return;
                                      }
                                      final url =
                                          "tel:${widget.shop.phoneNumber}";
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SliverToBoxAdapter(),
                    SliverPersistentHeader(
                      delegate: SliverAppBarDelegate(
                        minHeight: 60.0,
                        maxHeight: 60.0,
                        child: Center(
                            child: Column(
                          children: <Widget>[
                            Text(S.of(context).rateAndReviewTitle),
                            Hero(
                              child: RatingBar(
                                ratingWidget: RatingWidget(
                                    full: Icon(
                                      Icons.star,
                                      color: Colors.amberAccent,
                                    ),
                                    empty: Icon(
                                      Icons.star_border,
                                      color: Colors.amberAccent,
                                    ),
                                    half: Icon(
                                      Icons.star_half,
                                      color: Colors.amberAccent,
                                    )),
                                onRatingUpdate: (double value) {
                                  _authenticationBloc.user.then((user) {
                                    if (user.fullName != null) {
                                      Navigator.of(context).pushNamed(
                                        ReviewScreen.routeName,
                                        arguments: [
                                          value,
                                          widget.shop,
                                          _feedbackBloc
                                        ],
                                      );
                                    } else {
                                      Navigator.of(context).pushNamed(
                                        SignInScreen.routeName,
                                      );
                                    }
                                  });
                                },
                                itemCount: 5,
                                allowHalfRating: true,
                              ),
                              tag: "Rating",
                            ),
                          ],
                        )),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverAppBarDelegate(
                        minHeight: 50.0,
                        maxHeight: 50.0,
                        child: Material(
                          child: IntrinsicHeight(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(shop.rating.toStringAsFixed(2)),
                                      Icon(Icons.star),
                                    ],
                                  ),
                                ),
                                VerticalDivider(),
                                Expanded(
                                    child: Center(
                                        child:
                                            Text("${widgets.length} reviews"))),
                              ],
                            ),
                          ),
                          elevation: 1,
                        ),
                      ),
                    ),
                    SliverFixedExtentList(
                      itemExtent: 60.0,
                      delegate: SliverChildListDelegate(
                        widgets,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                      ),
                    ),
                  ],
                );
              },
            );
          }),
    ));
  }

  void _selectPhoneModalBottomSheet(context, List<String> phones) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: phones
                  .map((phone) => ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(phone),
                      onTap: () async {
                        final url = "tel:$phone";
                        if (await canLaunch(url)) {
                          await launch(url);
                        }
                      }))
                  .toList(),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
    _feedbackBloc.close();
    _authenticationBloc.close();
  }
}
