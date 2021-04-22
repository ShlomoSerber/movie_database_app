import 'package:flutter/material.dart';
import 'package:movie_database_app/top_rated_movie/MainTRMovie_widget.dart';

main(List<String> args) {
  runApp(
    MaterialApp(
      home: MainTRMovieWidget(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(),
      ),
    ),
  );
}
