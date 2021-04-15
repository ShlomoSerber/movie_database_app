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
            json["results"].map((x) => TRResult.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
