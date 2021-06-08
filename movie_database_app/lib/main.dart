import 'package:flutter/material.dart';
import 'package:movie_database_app/MainScreen_widget.dart';
import 'package:movie_database_app/popular_movie/MainPMovie_widget.dart';
import 'package:movie_database_app/searched_movie/MainSMovie_widget.dart';
import 'package:movie_database_app/top_rated_movie/MainTRMovie_widget.dart';

main(List<String> args) {
  runApp(
    MaterialApp(
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
