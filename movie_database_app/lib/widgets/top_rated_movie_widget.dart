import 'package:flutter/material.dart';
import 'package:movie_database_app/classes/top_rated_movie_class.dart';

class TopRatedMovie extends StatelessWidget {
  TRMovie movie = TRMovie.getTRMovieListFromJson();

  @override
  Widget build(context) {
    return Container(
      child: Text(movie(title)),
    );
  }
}
