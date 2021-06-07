import 'package:movie_database_app/searched_movie/SResult_class.dart';

class SMovie {
  SMovie({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int page;
  List<SResult> results;
  int totalPages;
  int totalResults;

  factory SMovie.fromJson(Map<dynamic, dynamic> json) => SMovie(
        page: json["page"],
        results: List<SResult>.from(
            json["results"].map((map) => SResult.fromJson(map))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
