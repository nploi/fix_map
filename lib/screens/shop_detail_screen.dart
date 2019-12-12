import 'dart:math';

import "package:cached_network_image/cached_network_image.dart";
import "package:fix_map/blocs/blocs.dart";
import "package:fix_map/generated/i18n.dart";
import "package:fix_map/models/models.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShopDetailScreen extends StatefulWidget {
  static final String routeName = "/shop_detail";
  final Shop shop;

  const ShopDetailScreen({Key key, this.shop}) : super(key: key);

  @override
  _ShopDetailScreenState createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  ShopDetailBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ShopDetailBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ShopDetailBloc, ShopDetailState>(
            bloc: bloc,
            builder: (context, state) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    title: Text(widget.shop.name),
                    expandedHeight: MediaQuery.of(context).size.height * 0.3,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: widget.shop.name,
                        child: CachedNetworkImage(
                          imageUrl: widget.shop.imageBig,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                          Text("Rating for shop"),
                          RatingBar(
                            ratingWidget: RatingWidget(
                                full: Icon(Icons.star),
                                empty: Icon(Icons.star_border),
                                half: Icon(Icons.star_half)),
                            onRatingUpdate: (double value) {},
                            itemCount: 5,
                            allowHalfRating: true,
                          ),
                        ],
                      )),
                    ),
                  ),
                  makeHeader("Review"),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                ],
              );
//              return Stack(
//                children: <Widget>[
//                  Container(
//                      foregroundDecoration:
//                          BoxDecoration(color: Colors.black26),
//                      height: 400,
//                      child: Hero(
//                        tag: widget.shop.name,
//                        child: CachedNetworkImage(
//                          imageUrl: widget.shop.imageBig,
//                          fit: BoxFit.cover,
//                        ),
//                      )),
//                  SingleChildScrollView(
//                    padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        const SizedBox(height: 250),
//                        Padding(
//                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                          child: Text(
//                            widget.shop.name,
//                            style: TextStyle(
//                                color: Colors.white,
//                                fontSize: 28.0,
//                                fontWeight: FontWeight.bold),
//                          ),
//                        ),
//                        Row(
//                          children: <Widget>[
//                            const SizedBox(width: 16.0),
//                            Container(
//                              padding: const EdgeInsets.symmetric(
//                                vertical: 8.0,
//                                horizontal: 16.0,
//                              ),
//                              decoration: BoxDecoration(
//                                  color: Theme.of(context).buttonColor,
//                                  borderRadius: BorderRadius.circular(20.0)),
//                              child: Text(
//                                "8.4/85 reviews",
//                                style: TextStyle(
//                                  fontSize: 13.0,
//                                  color:
//                                      Theme.of(context).textTheme.subhead.color,
//                                ),
//                              ),
//                            ),
//                            Spacer(),
//                            IconButton(
//                              color: Theme.of(context).primaryColorLight,
//                              icon: Icon(Icons.favorite_border),
//                              onPressed: () {},
//                            )
//                          ],
//                        ),
//                        Container(
//                          color: Theme.of(context).backgroundColor,
//                          padding: const EdgeInsets.all(32.0),
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            mainAxisSize: MainAxisSize.min,
//                            children: <Widget>[
//                              Row(
//                                children: <Widget>[
//                                  Expanded(
//                                    child: Column(
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        Row(
//                                          children: <Widget>[
//                                            Icon(
//                                              Icons.star,
//                                              color: Theme.of(context)
//                                                  .colorScheme
//                                                  .secondary,
//                                            ),
//                                            Icon(
//                                              Icons.star,
//                                              color: Theme.of(context)
//                                                  .colorScheme
//                                                  .secondary,
//                                            ),
//                                            Icon(
//                                              Icons.star,
//                                              color: Theme.of(context)
//                                                  .colorScheme
//                                                  .secondary,
//                                            ),
//                                            Icon(
//                                              Icons.star,
//                                              color: Theme.of(context)
//                                                  .colorScheme
//                                                  .secondary,
//                                            ),
//                                            Icon(
//                                              Icons.star_border,
//                                              color: Theme.of(context)
//                                                  .colorScheme
//                                                  .secondary,
//                                            ),
//                                          ],
//                                        ),
//                                        Text.rich(
//                                          TextSpan(children: [
//                                            WidgetSpan(
//                                                child: Icon(
//                                              Icons.location_on,
//                                              size: 16.0,
//                                            )),
//                                            TextSpan(text: "8 km to centrum")
//                                          ]),
//                                          style: TextStyle(fontSize: 12.0),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                  Column(
//                                    children: <Widget>[
//                                      Text(
//                                        "\$ 200",
//                                        style: TextStyle(
//                                            color: Theme.of(context)
//                                                .colorScheme
//                                                .secondary,
//                                            fontWeight: FontWeight.bold,
//                                            fontSize: 20.0),
//                                      ),
//                                      Text(
//                                        "/per night",
//                                        style: TextStyle(
//                                          fontSize: 12.0,
//                                        ),
//                                      )
//                                    ],
//                                  )
//                                ],
//                              ),
//                              const SizedBox(height: 30.0),
//                              SizedBox(
//                                width: double.infinity,
//                                child: RaisedButton(
//                                  shape: RoundedRectangleBorder(
//                                      borderRadius:
//                                          BorderRadius.circular(30.0)),
//                                  child: Text(
//                                    "Book Now",
//                                    style: TextStyle(
//                                        fontWeight: FontWeight.normal),
//                                  ),
//                                  padding: const EdgeInsets.symmetric(
//                                    vertical: 16.0,
//                                    horizontal: 32.0,
//                                  ),
//                                  onPressed: () {},
//                                ),
//                              ),
//                              const SizedBox(height: 30.0),
//                              Text(
//                                "Description".toUpperCase(),
//                                style: TextStyle(
//                                    fontWeight: FontWeight.w600,
//                                    fontSize: 14.0),
//                              ),
//                              const SizedBox(height: 10.0),
//                              Text(
//                                "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ratione architecto autem quasi nisi iusto eius ex dolorum velit! Atque, veniam! Atque incidunt laudantium eveniet sint quod harum facere numquam molestias?",
//                                textAlign: TextAlign.justify,
//                                style: TextStyle(
//                                    fontWeight: FontWeight.w300,
//                                    fontSize: 14.0),
//                              ),
//                              const SizedBox(height: 10.0),
//                              Text(
//                                "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ratione architecto autem quasi nisi iusto eius ex dolorum velit! Atque, veniam! Atque incidunt laudantium eveniet sint quod harum facere numquam molestias?",
//                                textAlign: TextAlign.justify,
//                                style: TextStyle(
//                                    fontWeight: FontWeight.w300,
//                                    fontSize: 14.0),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ],
//              );
            }));
  }

  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 60.0,
        child: Material(
          child: Center(child: Text(headerText)),
          elevation: 1,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
