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
            return Center(child: LinearProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: [Text('Error:'), Text('Data not available')],
              ),
            );
          }

          final Map parsed = json.decode(snapshot.data.body);
          results = TRMovie.fromJson(parsed);

          return ListView.builder(
            itemBuilder: (context, index) {
              return SafeArea(
                child: Container(
                  child: Row(
                    children: [
                      //Container(
                      //child: Image.network(
                      //imageLink + results.results[index].posterPath),
                      //),
                      Container(
                        height: 40,
                        width: 40,
                        child: Image.network(
                          imageLink + results.results[index].posterPath,
                          scale: 0.1,
                          repeat: ImageRepeat.noRepeat,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: results.results.length,
          );
        },
      ),
    );
  }
}
