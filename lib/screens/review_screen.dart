import 'package:fix_map/models/models.dart';
import 'package:fix_map/widgets/input.dart';
import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

class ReviewScreen extends StatefulWidget {
  static final String routeName = "/review";
  final double rating;
  final Shop shop;

  const ReviewScreen({Key key, this.rating, this.shop}) : super(key: key);
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController _controller = TextEditingController();
  double rating;

  @override
  void initState() {
    super.initState();
    rating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shop.name),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Rate and review"),
                  SizedBox(
                    height: 5,
                  ),
                  RatingBar(
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
                      rating = value;
                    },
                    itemCount: 5,
                    allowHalfRating: true,
                    initialRating: widget.rating,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _controller,
                onChanged: (value) {},
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder()),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: RaisedButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "Post",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
