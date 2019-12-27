import "package:cached_network_image/cached_network_image.dart";
import "package:fix_map/blocs/blocs.dart";
import "package:fix_map/generated/i18n.dart";
import "package:fix_map/models/models.dart";
import "package:fix_map/screens/review.dart";
import "package:fix_map/screens/screens.dart";
import "package:fix_map/widgets/widgets.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
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
    _bloc = ShopDetailBloc();
    _feedbackBloc = FeedbackBloc();
    _authenticationBloc = AuthenticationBloc();
    _refresh();
    shop = widget.shop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<FeedbackBloc, FeedbackState>(
      bloc: _feedbackBloc,
      listener: (context, state) {
        if (state is FeedbackAddedFeedbackState) {
          _refresh();
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
                final List<Widget> feedbackWidgets = [];
                List<FeedbackEntity> listFeedback = [];

                if (state is FeedbackLoadedListFeedbackState) {
                  listFeedback = state.listFeedback;
                  state.listFeedback
                      .forEach((feedback) => feedbackWidgets.add(Container(
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
                              title: Text(feedback.userFullName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  RatingBar(
                                    itemSize: 15,
                                    initialRating: feedback.rating,
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
                                    itemCount: 5,
                                    onRatingUpdate: null,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(feedback.comment)
                                ],
                              ),
                            ),
                          )));
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    _refresh();
                    await Future.delayed(Duration(milliseconds: 400));
                  },
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.3,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
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
                      SliverToBoxAdapter(
                        child: buildRating(listFeedback),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(shop.rating.toStringAsFixed(2)),
                                        Icon(Icons.star),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(),
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                              "${feedbackWidgets.length} ${S.of(context).reviewsTitle}"))),
                                ],
                              ),
                            ),
                            elevation: 1,
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(feedbackWidgets),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                    ],
                  ),
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

  Widget buildRating(List<FeedbackEntity> listFeedback) {
    return FutureBuilder<User>(
        future: _authenticationBloc.user,
        builder: (context, snapshot) {
          FeedbackEntity feedback;

          if (snapshot.hasData &&
              snapshot.data.fullName.isNotEmpty &&
              listFeedback.isNotEmpty) {
            feedback = listFeedback
                .where((value) => value.userId == snapshot.data.id)
                .first;
          }

          return Center(
              child: !snapshot.hasData
                  ? CircularProgressIndicator()
                  : feedback != null
                      ? Container()
                      : Column(
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
                              ),
                              tag: "Rating",
                            ),
                          ],
                        ));
        });
  }

  void _refresh() {
    _bloc.add(ShopDetailByHashEvent(widget.shop.hash));
    _feedbackBloc.add(FeedbackGetListFeedbackEvent(widget.shop.hash));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
    _feedbackBloc.close();
    _authenticationBloc.close();
  }
}
