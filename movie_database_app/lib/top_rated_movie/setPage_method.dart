import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_database_app/top_rated_movie/TRMovie_class.dart';
import 'package:movie_database_app/top_rated_movie/TRResult_class.dart';
import 'package:movie_database_app/top_rated_movie/tRMovieLinks_variables.dart';

//Future<List> setPage(int pageNumber) async {
//List<TRResult> videosList = [];

//var result = await http.get(
//Uri.parse(
//tRMovieLink + '&page=' + pageNumber.toString(),
//),
//);
//if (result.statusCode == 200) {
//final Map parsed = json.decode(result.body);
//for (int i = 0; i < parsed.length; i++) {
//videosList.add(TRMovie.fromJson(parsed).results[i]);
//}
//}

//return videosList;
//}
