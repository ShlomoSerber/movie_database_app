import 'package:flutter/material.dart';
import 'package:movie_database_app/full_movie/Movie_widget.dart';
import 'package:movie_database_app/top_rated_movie/MainTRMovie_widget.dart';

main(List<String> args) {
  runApp(
    MaterialApp(
      home: MainTRMovie(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
