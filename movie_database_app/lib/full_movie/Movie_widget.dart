import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_database_app/full_movie/Movie_class.dart';
import 'package:movie_database_app/full_movie/api_links.dart';
import 'package:movie_database_app/global_theme/global_theme.dart';

class FullMovie extends StatelessWidget {
  // Global class variables

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: FutureBuilder(
        future: http.get(
          Uri.parse(
            getMovieLink(399566),
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          final Map parsed = json.decode(snapshot.data.body);
          Movie movie = Movie.fromJson(parsed);
          double width = MediaQuery.of(context).size.width;

          return Container(
            child: Text(movie.imdbId),
          );
        },
      ),
    );
  }
}
