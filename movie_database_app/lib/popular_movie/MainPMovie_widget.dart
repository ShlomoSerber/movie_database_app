import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_database_app/full_movie/Movie_widget.dart';
import 'package:movie_database_app/global_theme/global_theme.dart';
import 'package:movie_database_app/popular_movie/PMovie_class.dart';
import 'package:movie_database_app/popular_movie/api_links.dart';
import 'package:movie_database_app/top_rated_movie/MainTRMovie_widget.dart';

class MainPMovie extends StatefulWidget {
  @override
  _MainPMovieState createState() => _MainPMovieState();
}

class _MainPMovieState extends State<MainPMovie> {
  // Global class variables:
  PMovie results;
  int pageNumber = 1;
  int finalPage;
  double width;
  // Big button border radius
  MaterialStateProperty<OutlinedBorder> bigButtonShape =
      MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  );
  // Small button border radius
  MaterialStateProperty<OutlinedBorder> smallButtonShape =
      MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Center(
          child: Text('Popular Movies'),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case 1:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainTRMovie(),
                    ),
                  );
                  break;
                case 2:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPMovie(),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Top Rated'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Most Popular'),
                value: 2,
              )
            ],
          )
        ],
      ),
      body: FutureBuilder(
        future: http.get(
          Uri.parse(
            getPMovieLink(pageNumber),
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          final Map parsed = json.decode(snapshot.data.body);
          results = PMovie.fromJson(parsed);
          finalPage = results.totalPages;
          width = MediaQuery.of(context).size.width;
          // results.results[index].id

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
                    return TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullMovie(
                              id: results.results[index].id,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: width * 0.01,
                        color: cardBackgroundColor,
                        shadowColor: shadowColor,
                        shape: cardShape,
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
                                borderRadius: cardRadius,
                                child: results.results[index].posterPath != null
                                    ? Image.network(imageLink +
                                        results.results[index].posterPath)
                                    : Image.asset(
                                        'images/no_image_available.png'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * 0.02,
                                right: width * 0.02,
                                top: width * 0.01,
                                bottom: width * 0.005,
                              ),
                              child: Text(
                                results.results[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: textScaleFactor(
                                    scaleFactor: width,
                                  ),
                                  color: textColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * 0.02,
                                right: width * 0.02,
                                top: width * 0.005,
                                bottom: width * 0.01,
                              ),
                              child: Center(
                                child: Text(
                                  'Poularity: ' +
                                      results.results[index].popularity
                                          .toString(),
                                  style: TextStyle(
                                    fontSize: textScaleFactor(
                                      scaleFactor: width,
                                    ),
                                    color: textColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: width * 0.11,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: smallRadius,
                    color: blackTransparent,
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

  MaterialStateProperty<Color> getButtonColor(int page) {
    return page == pageNumber ? currentButtonColor : otherButtonsColor;
  }

  Widget buildButton(int page, {var color, var label}) {
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
        backgroundColor: color ?? getButtonColor(page),
        side: MaterialStateProperty.all(
          BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      child: label ??
          Text(
            page.toString(),
            style: TextStyle(
              color: textColor,
              fontSize: textScaleFactor(scaleFactor: width),
            ),
          ),
    );
  }

  List<Widget> buildButtons() {
    List<Widget> buttons = [];

    // Previous button
    if (pageNumber > 1) {
      buttons.add(
        buildButton(
          pageNumber - 1,
          label: Icon(
            Icons.arrow_back,
            color: textColor,
            size: textScaleFactor(scaleFactor: width),
          ),
        ),
      );
    }

    // First page
    if (pageNumber > 3) {
      buttons.add(buildButton(1, color: extremeButtonColor));
    }

    // Previous 2 pages
    for (int i = pageNumber - 2; i < pageNumber; i++) {
      if (i >= 1) buttons.add(buildButton(i));
    }

    buttons.add(buildButton(pageNumber));

    // Next 2 pages
    for (int i = pageNumber + 1; i < pageNumber + 3; i++) {
      if (i <= finalPage) buttons.add(buildButton(i));
    }

    // last button
    if (pageNumber + 2 < finalPage) {
      buttons.add(buildButton(finalPage, color: extremeButtonColor));
    }

    // next button
    if (pageNumber + 1 <= finalPage) {
      buttons.add(
        buildButton(
          pageNumber + 1,
          label: Icon(
            Icons.arrow_forward,
            color: textColor,
            size: textScaleFactor(scaleFactor: width),
          ),
        ),
      );
    }

    return buttons;
  }

  Route<Object> MainTRMovieWidget() {}
}
