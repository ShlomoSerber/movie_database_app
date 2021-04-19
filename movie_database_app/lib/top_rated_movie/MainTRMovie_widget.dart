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
              Radius.circular(40.0),
            ),
          );

          return GridView.builder(
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white54,
                margin: EdgeInsets.all(4.0),
                shape: shape,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: ,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40.0),
                        child: Image.network(
                          imageLink + results.results[index].posterPath,
                        ),
                      ),
                      Center(
                        child: Text(
                          results.results[index].title,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
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
