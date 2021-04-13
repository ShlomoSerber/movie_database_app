import 'package:dio/dio.dart';

Future getTRMoviePage(int page, String apiKey) async {
  Response topRatedMovie = await Dio().get(
      'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=en-US&page=$page');
  Map<String, dynamic> tRMoviePageJson = topRatedMovie.data;
  return tRMoviePageJson;
}

Future getTRMovieList(int page, String apiKey) async {
  Response topRatedMovie = await Dio().get(
      'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=en-US&page=$page');
  Map<String, dynamic> tRMoviePageJson = topRatedMovie.data;
  List<Map<String, dynamic>> trMovieListJson = tRMoviePageJson['results'];
  return trMovieListJson;
}

Future getTRMovie(int page, String apiKey, int movieNumber) async {
  Response topRatedMovie = await Dio().get(
      'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=en-US&page=$page');
  Map<String, dynamic> tRMoviePageJson = topRatedMovie.data;
  List<Map<String, dynamic>> trMovieListJson = tRMoviePageJson['results'];
  Map<String, dynamic> tRMovie = trMovieListJson[movieNumber];
  return tRMovie;
}
