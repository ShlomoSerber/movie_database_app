import 'package:movie_database_app/popular_movie/PResult_class.dart';

class PMovie {
  PMovie({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int page;
  List<PResult> results;
  int totalPages;
  int totalResults;

  factory PMovie.fromJson(Map<dynamic, dynamic> json) => PMovie(
        page: json["page"],
        results: List<PResult>.from(
            json["results"].map((map) => PResult.fromJson(map))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
