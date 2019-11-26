import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fix_map/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  final Shop shop;
  final Function onPressed;
  const ShopCard({Key key, this.shop, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: RawMaterialButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      child: CachedNetworkImage(
                        imageUrl: shop.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(child: AutoSizeText(shop.name)),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: AutoSizeText(
                    shop.address,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(children: getRatings()),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Status: ${shop.status}",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onPressed: this.onPressed,
      ),
    );
  }

  List<Widget> getRatings() {
    List<Widget> ratings = [];
    for (int i = 0; i < 5; i++) {
      if (i < shop.rating) {
        ratings.add(new Icon(Icons.star, color: Colors.yellow));
      } else {
        ratings.add(new Icon(Icons.star_border, color: Colors.black));
      }
    }
    return ratings;
  }
}
