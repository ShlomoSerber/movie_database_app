import 'package:movie_database_app/services/get_top_rated_movie.dart';

class TRMovie {
  int _page = 1;
  String _key = '0e685fd77fb3d76874a3ac26e0db8a4b';

  TRMovie({
    required bool adult,
    required String backdropPath,
    required List<int> genreIds,
    required int id,
    required String originalLanguage,
    required String overview,
    required double popularity,
    required String posterPath,
    required DateTime releaseDate,
    required String title,
    required bool video,
    required double voteAverage,
    required int voteCount,
  });

  TRMovie.getTRMovieFromJson() {
    List<Map<String, dynamic>> tRMovieJson =
        getTRMovieList(_page, _key) as List<Map<String, dynamic>>;
    for (var i = 0; i <= tRMovieJson.length; i++) {
      Map<String, dynamic> tRMovie = tRMovieJson[i];
      TRMovie(
        adult: tRMovie['adult'],
        backdropPath: tRMovie['backdrop_path'],
        genreIds: tRMovie['genre_ids'],
        id: tRMovie['id'],
        originalLanguage: tRMovie['original_language'],
        overview: tRMovie['overview'],
        popularity: tRMovie['popularity'],
        posterPath: tRMovie['poster_path'],
        releaseDate: tRMovie['releaseDate'],
        title: tRMovie['title'],
        video: tRMovie['video'],
        voteAverage: tRMovie['voteAverage'],
        voteCount: tRMovie['voteCount'],
      );
    }
  }
}
