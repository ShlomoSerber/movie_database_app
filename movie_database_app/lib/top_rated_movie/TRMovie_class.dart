import 'package:movie_database_app/top_rated_movie/TRResult_class.dart';

class TRMovie {
  TRMovie({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int page;
  List<TRResult> results;
  int totalPages;
  int totalResults;

  factory TRMovie.fromJson(Map<dynamic, dynamic> json) => TRMovie(
        page: json["page"],
        results: List<TRResult>.from(
            json["results"].map((map) => TRResult.fromJson(map))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
