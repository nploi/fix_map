import "package:cached_network_image/cached_network_image.dart";
import "package:fix_map/blocs/blocs.dart";
import 'package:fix_map/generated/i18n.dart';
import "package:fix_map/models/models.dart";
import "package:fix_map/screens/review_screen.dart";
import "package:fix_map/widgets/widgets.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

class ShopDetailScreen extends StatefulWidget {
  static final String routeName = "/shop_detail";
  final Shop shop;

  const ShopDetailScreen({Key key, this.shop}) : super(key: key);

  @override
  _ShopDetailScreenState createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  ShopDetailBloc bloc;
  Shop shop = Shop();

  @override
  void initState() {
    super.initState();
    bloc = ShopDetailBloc()..add(ShopDetailByHashEvent(widget.shop.hash));
    shop = widget.shop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ShopDetailBloc, ShopDetailState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is ShopDetailFoundState) {
                shop = state.shop;
              }
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.height * 0.3,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: widget.shop.name,
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
                            onPressed: () {},
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
                                  onPressed: () {},
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
                                Navigator.of(context).pushNamed(
                                  ReviewScreen.routeName,
                                  arguments: [value, widget.shop],
                                );
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
                                  child: Center(child: Text("10 reviews"))),
                            ],
                          ),
                        ),
                        elevation: 1,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                ],
              );
            }));
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
}
