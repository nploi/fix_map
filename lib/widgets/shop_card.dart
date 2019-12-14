import "package:auto_size_text/auto_size_text.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:fix_map/models/models.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

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
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Hero(
                      tag: shop.name + "-" + shop.address,
                      child: CachedNetworkImage(
                        imageUrl: shop.image,
                        fit: BoxFit.contain,
                        imageBuilder: (context, provider) {
                          return CircleAvatar(
                            backgroundImage: provider,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: AutoSizeText(shop.name)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: AutoSizeText(
                    shop.address,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
//                Row(children: getRatings()),
                shop.phoneNumber.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Phone: ${shop.phoneNumber}",
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        onPressed: this.onPressed,
      ),
    );
  }

  List<Widget> getRatings() {
    final List<Widget> ratings = [];
    for (int i = 0; i < 5; i++) {
      if (i < shop.rating) {
        ratings.add(Icon(Icons.star, color: Colors.yellow));
      } else {
        ratings.add(Icon(Icons.star_border, color: Colors.black));
      }
    }
    return ratings;
  }
}
