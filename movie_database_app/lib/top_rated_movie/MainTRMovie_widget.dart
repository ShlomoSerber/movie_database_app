import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_database_app/top_rated_movie/TRMovie_class.dart';
import 'package:movie_database_app/top_rated_movie/tRMovieLinks_variables.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MainTRMovieWidget extends StatefulWidget {
  @override
  _MainTRMovieWidgetState createState() => _MainTRMovieWidgetState();
}

class _MainTRMovieWidgetState extends State<MainTRMovieWidget> {
  // Global variables:
  TRMovie results;
  int pageNumber = 1;
  int finalPage;
  double width;
  Widget fullStar = Icon(
    Icons.star,
    color: Colors.black,
  );
  Widget emptyStar = Icon(
    Icons.star_outline,
    color: Colors.black,
  );
  Widget halfStar = Icon(
    Icons.star_half,
    color: Colors.black,
  );
  ShapeBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text('Top Rated Movies')),
      ),
      body: FutureBuilder(
        future: http.get(
          Uri.parse(
            getTRMovieLink(pageNumber),
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  Center(
                    child: Text('Error:'),
                  ),
                  Center(
                    child: Text('Data not available'),
                  ),
                ],
              ),
            );
          }

          final Map parsed = json.decode(snapshot.data.body);
          results = TRMovie.fromJson(parsed);
          finalPage = results.totalPages;

          return Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(width * 0.01),
                child: GridView.builder(
                  itemCount: results.results.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: width * 0.005,
                    crossAxisSpacing: width * 0.005,
                    crossAxisCount: 2,
                    childAspectRatio: 0.59,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: width * 0.01,
                      color: Colors.white,
                      shadowColor: Colors.black,
                      shape: shape,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: width * 0.02,
                              right: width * 0.02,
                              top: width * 0.02,
                              bottom: width * 0.01,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                imageLink + results.results[index].posterPath,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: width * 0.02,
                              right: width * 0.02,
                              top: width * 0.01,
                              bottom: width * 0.01,
                            ),
                            child: Text(
                              results.results[index].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: width * 0.03,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: width * 0.02,
                              right: width * 0.02,
                              top: width * 0.01,
                              bottom: width * 0.02,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RatingBar(
                                    initialRating:
                                        results.results[index].voteAverage,
                                    itemSize: width * 0.03,
                                    allowHalfRating: true,
                                    direction: Axis.horizontal,
                                    itemCount: 10,
                                    ratingWidget: RatingWidget(
                                      full: fullStar,
                                      half: halfStar,
                                      empty: emptyStar,
                                    ),
                                    onRatingUpdate: null,
                                  ),
                                  Text(
                                    '(' +
                                        results.results[index].voteAverage
                                            .toString() +
                                        ')',
                                    style: TextStyle(
                                      fontSize: width * 0.03,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: width,
                  ),
                  color: Color.fromRGBO(0, 0, 0, 0.9),
                  child: ButtonBar(
                    layoutBehavior: ButtonBarLayoutBehavior.padded,
                    children: buildButtons(pageNumber),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  var backgroundColor = MaterialStateProperty.all(Colors.white);
  var onTap = MaterialStateProperty.all(Colors.grey);

  Widget buildButton(int page, {String label}) {
    return InkWell(
      onTap: () {
        backgroundColor = onTap;
      },
      child: TextButton(
        onPressed: () {
          setState(() {
            pageNumber = page;
          });
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(width * 0.01),
          backgroundColor: backgroundColor,
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            width * 0.01,
          ),
          child: Text(
            label ?? page.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: width * 0.03,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildButtons(int startButton) {
    const int maxButtons = 3;
    var condition = finalPage - maxButtons;

    List<Widget> buttons = [];

    // previous button
    if (pageNumber > 1) {
      buttons.add(buildButton(pageNumber--, label: '<< Previous'));
    }

    // first button
    if (pageNumber != 1) {
      buttons.add(buildButton(1, label: '1'));
    }

    // page buttons
    for (int i = 0; i < maxButtons; i++) {
      if (i < condition) {
        buttons.add(buildButton(startButton + 1 + i));
      }
    }

    // last button
    buttons.add(buildButton(finalPage));

    // next button
    if (pageNumber < finalPage) {
      buttons.add(buildButton(pageNumber++, label: 'Next >>'));
    }

    return buttons;
  }
}
