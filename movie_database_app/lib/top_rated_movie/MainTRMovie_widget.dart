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
      backgroundColor: Colors.black,
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
              Radius.circular(30.0),
            ),
          );
          double aspectRatio = MediaQuery.of(context).size.aspectRatio;

          return GridView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: aspectRatio * 5,
                color: Colors.white60,
                shadowColor: Colors.white,
                shape: shape,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: aspectRatio * 6,
                          right: aspectRatio * 6,
                          top: aspectRatio * 6,
                          bottom: aspectRatio * 3,
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          child: Image.network(
                            imageLink + results.results[index].posterPath,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: aspectRatio * 6,
                        right: aspectRatio * 6,
                        top: aspectRatio * 3,
                        bottom: aspectRatio * 6,
                      ),
                      child: Center(
                        child: Text(
                          results.results[index].title,
                          style: TextStyle(
                            fontSize: aspectRatio * 17.5,
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
              crossAxisCount: 2,
            ),
          );
        },
      ),
    );
  }
}
