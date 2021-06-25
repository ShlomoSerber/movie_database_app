import 'package:flutter/material.dart';
import 'package:movie_database_app/global_theme/global_theme.dart';
import 'package:movie_database_app/popular_movie/MainPMovie_widget.dart';
import 'package:movie_database_app/searched_movie/MainSMovie_widget.dart';
import 'package:movie_database_app/top_rated_movie/MainTRMovie_widget.dart';

class MainScreen extends StatelessWidget {
  double width;
  TextEditingController controller = TextEditingController();
  String query;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Center(
          child: Text('Proyecto de Nivelacion'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.01),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainTRMovie(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(width * 0.01),
                    height: width * 0.35,
                    width: width * 0.49,
                    child: Card(
                      color: cardBackgroundColor,
                      shape: cardShape,
                      shadowColor: Colors.black,
                      elevation: width * 0.1,
                      child: Center(
                        child: Text(
                          'Top Rated Movies',
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: appBarColor,
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPMovie(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(width * 0.01),
                    height: width * 0.35,
                    width: width * 0.49,
                    child: Card(
                      color: cardBackgroundColor,
                      shape: cardShape,
                      shadowColor: Colors.black,
                      elevation: width * 0.1,
                      child: Center(
                        child: Text(
                          'Most Popular Movies',
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: appBarColor,
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(width * 0.02),
              height: width * 0.40,
              width: width * 0.96,
              child: Card(
                color: cardBackgroundColor,
                shape: cardShape,
                shadowColor: Colors.black,
                elevation: width * 0.1,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: width * 0.05,
                        left: width * 0.05,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Search for movies:',
                        style: TextStyle(
                          color: textColor,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(width * 0.02),
                      width: width * 0.85,
                      child: TextField(
                        style: TextStyle(fontSize: width * 0.03),
                        controller: controller,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          query = value;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        right: width * 0.04,
                        top: width * 0.01,
                      ),
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        child: Text('Search'),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainSMovie(query),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
