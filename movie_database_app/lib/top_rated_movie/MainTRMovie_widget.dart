import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_database_app/top_rated_movie/TRMovie_class.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_database_app/top_rated_movie/api_links.dart';

class MainTRMovie extends StatefulWidget {
  @override
  _MainTRMovieState createState() => _MainTRMovieState();
}

class _MainTRMovieState extends State<MainTRMovie> {
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
          width = MediaQuery.of(context).size.width;

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
                  height: width * 0.11,
                  width: width * 0.87,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.013),
                    child: ButtonBar(
                      buttonPadding: EdgeInsets.all(width * 0.001),
                      alignment: MainAxisAlignment.center,
                      children: buildButtons(),
                    ),
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

  Widget next = Icon(
    Icons.arrow_forward,
    color: Colors.black,
  );

  Widget buildButton(int page, {var label}) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          pageNumber = page;
        });
      },
      style: ButtonStyle(
        minimumSize:
            MaterialStateProperty.all(Size(width * 0.11, width * 0.15)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
        backgroundColor: backgroundColor,
        side: MaterialStateProperty.all(
          BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      child: label,
    );
  }

  List<Widget> buildButtons() {
    const int maxButtons = 2;
    int condition = finalPage - maxButtons;

    List<Widget> buttons = [];

    // Previous button
    if (pageNumber > 1) {
      buttons.add(
        buildButton(
          pageNumber = pageNumber - 1,
          label: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: width * 0.03,
          ),
        ),
      );
    }

    // First page
    bool condition1 = pageNumber == 1;
    bool condition2 = pageNumber == 2;
    bool condition3 = pageNumber == 3;
    bool finalCondition = condition1 || condition2 || condition3 == true;
    if (finalCondition == false) {
      buttons.add(
        buildButton(
          1,
          label: Text(
            '1',
            style: TextStyle(
              color: Colors.black,
              fontSize: width * 0.03,
            ),
          ),
        ),
      );
    }

    // Previous 2 pages
    for (int i = 0; i < 2; i++) {
      int previousNumber = pageNumber - 1 + i;
      if (previousNumber >= 1) {
        buttons.add(
          buildButton(
            previousNumber,
            label: Text(
              previousNumber.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.03,
              ),
            ),
          ),
        );
      }
    }

    // Next 2 pages
    for (int i = 0; i < 2; i++) {
      int nextNumber = pageNumber + 1 + i;
      if (nextNumber >= 1) {
        buttons.add(
          buildButton(
            nextNumber,
            label: Text(
              nextNumber.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.03,
              ),
            ),
          ),
        );
      }
    }

    // last button
    if (pageNumber != finalPage) {
      buttons.add(
        buildButton(
          finalPage,
          label: Text(
            finalPage.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: width * 0.03,
            ),
          ),
        ),
      );
    }

    // next button
    if (pageNumber == finalPage) {
      int nextPage = pageNumber + 1;
      buttons.add(
        buildButton(
          nextPage,
          label: Icon(
            Icons.arrow_forward,
            color: Colors.black,
            size: width * 0.03,
          ),
        ),
      );
    }

    return buttons;
  }
}
