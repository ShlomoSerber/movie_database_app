import 'package:movie_database_app/services/get_top_rated_movie.dart';

class TRMovie {
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

  factory TRMovie.getTRMovieListFromJson() {
    List<Map<String, dynamic>> tRMovieJson =
        getTRMovieList(1, '0e685fd77fb3d76874a3ac26e0db8a4b')
            as List<Map<String, dynamic>>;
    Map<String, dynamic> tRMovie = tRMovieJson[1];
    final adult = tRMovie['adult'];
    final backdropPath = tRMovie['backdrop_path'];
    final genreIds = tRMovie['genre_ids'];
    final id = tRMovie['id'];
    final originalLanguage = tRMovie['original_language'];
    final overview = tRMovie['overview'];
    final popularity = tRMovie['popularity'];
    final posterPath = tRMovie['poster_path'];
    final releaseDate = tRMovie['releaseDate'];
    final title = tRMovie['title'];
    final video = tRMovie['video'];
    final voteAverage = tRMovie['voteAverage'];
    final voteCount = tRMovie['voteCount'];

    return TRMovie(
        adult: adult,
        backdropPath: backdropPath,
        genreIds: genreIds,
        id: id,
        originalLanguage: originalLanguage,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        releaseDate: releaseDate,
        title: title,
        video: video,
        voteAverage: voteAverage,
        voteCount: voteCount);
  }

  //final bool adult;
  //final String backdropPath;
  //final List<int> genreIds;
  //final int id;
  //final String originalLanguage;
  //final String overview;
  //final double popularity;
  //final String posterPath;
  //final DateTime releaseDate;
  //final String title;
  //final bool video;
  //final double voteAverage;
  //final int voteCount;
}
