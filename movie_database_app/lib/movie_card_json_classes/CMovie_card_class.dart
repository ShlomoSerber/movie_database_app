import 'package:movie_database_app/movie_card_json_classes/Result_class.dart';

class CMovie {
  CMovie({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  factory CMovie.fromJson(Map<dynamic, dynamic> json) => CMovie(
        page: json["page"],
        results: List<Result>.from(
            json["results"].map((map) => Result.fromJson(map))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
