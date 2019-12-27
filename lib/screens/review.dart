import "package:fix_map/blocs/blocs.dart";
import "package:fix_map/generated/i18n.dart";
import "package:fix_map/models/models.dart";
import "package:fix_map/widgets/widgets.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:fluttertoast/fluttertoast.dart";

class ReviewScreen extends StatefulWidget {
  static final String routeName = "/review";
  final double rating;
  final Shop shop;
  final FeedbackBloc bloc;

  const ReviewScreen({Key key, this.rating, this.shop, this.bloc})
      : super(key: key);
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
      body: BlocListener<FeedbackBloc, FeedbackState>(
        bloc: widget.bloc,
        listener: (context, state) {
          if (state is FeedbackErrorState) {
            Fluttertoast.showToast(msg: state.message);
          }
          if (state is FeedbackAddedFeedbackState) {
            Fluttertoast.showToast(msg: S.of(context).successMessage);
            Navigator.of(context).pop();
          }
        },
        child: CustomOfflineBuilder(
          child: BlocBuilder<FeedbackBloc, FeedbackState>(
              bloc: widget.bloc,
              builder: (context, state) {
                return Stack(
                  children: <Widget>[
                    ListView(
                      padding: EdgeInsets.all(20),
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(S.of(context).rateAndReviewTitle),
                            SizedBox(
                              height: 5,
                            ),
                            Hero(
                              tag: "Rating",
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
                                  rating = value;
                                },
                                itemCount: 5,
                                initialRating: widget.rating,
                              ),
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
                              contentPadding: EdgeInsets.all(8),
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
                          onPressed: () {
                            widget.bloc.add(FeedbackAddFeedbackEvent(
                                widget.shop.hash, rating, _controller.text));
                          },
                          color: Theme.of(context).primaryColor,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 20,
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              S.of(context).confirmTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    state is FeedbackLoadingState
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                            color: Colors.white.withOpacity(0.8),
                          )
                        : Container()
                  ],
                );
              }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
