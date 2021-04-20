import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_database_app/top_rated_movie/TRMovie_class.dart';
import 'package:movie_database_app/top_rated_movie/tRMovieLinks_variables.dart';

class MainTRMovieWidget extends StatefulWidget {
  @override
  _MainTRMovieWidgetState createState() => _MainTRMovieWidgetState();
}

class _MainTRMovieWidgetState extends State<MainTRMovieWidget> {
  TRMovie results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: FutureBuilder(
        future: http.get(Uri.parse(tRMovieLink)),
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
          ShapeBorder shape = RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          );
          double width = MediaQuery.of(context).size.width;

          return Padding(
            padding: EdgeInsets.all(width * 0.007),
            child: GridView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: width * 0.007,
                  color: Colors.white,
                  shadowColor: Colors.black,
                  shape: shape,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: width * 0.02,
                          right: width * 0.02,
                          top: width * 0.02,
                          bottom: width * 0.005,
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
                          top: width * 0.015,
                          bottom: width * 0.01,
                        ),
                        child: Center(
                          child: Text(
                            results.results[index].title,
                            style: TextStyle(
                              fontSize: width * 0.03,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: results.results.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: width * 0.005,
                crossAxisSpacing: width * 0.005,
                crossAxisCount: 2,
                childAspectRatio: 0.64,
              ),
            ),
          );
        },
      ),
    );
  }
}
