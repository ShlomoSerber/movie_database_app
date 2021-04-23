class Movie {
  Movie({
    this.adult,
    this.backdropPath,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool adult;
  String backdropPath;
  // Here i skipped the 'belongs to collection' map
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  DateTime releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  factory Movie.fromJson(Map<dynamic, dynamic> json) => Movie(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        budget: json['budget'],
        genres: List<Genre>.from(
          json['production_companies'].map(
            (map) => Genre.fromJson(map),
          ),
        ),
        homepage: json['homepage'],
        id: json['id'],
        imdbId: json['imdb_id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        productionCompanies: List<ProductionCompany>.from(
          json['production_companies'].map(
            (map) => ProductionCompany.fromJson(map),
          ),
        ),
        productionCountries: List<ProductionCountry>.from(
          json['production_countries'].map(
            (map) => ProductionCountry.fromJson(map),
          ),
        ),
        releaseDate: json['release_date'],
        revenue: json['revenue'],
        runtime: json['runtime'],
        spokenLanguages: List<SpokenLanguage>.from(
          json['spoken_languages'].map(
            (map) => SpokenLanguage.fromJson(map),
          ),
        ),
        status: json['status'],
        tagline: json['tagline'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
      );
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json['id'],
        name: json['name'],
      );
}

class ProductionCompany {
  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  int id;
  String logoPath;
  String name;
  String originCountry;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json['id'],
        logoPath: json['logo_path'],
        name: json['name'],
        originCountry: json['origin_country'],
      );
}

class ProductionCountry {
  ProductionCountry({
    this.iso3166_1,
    this.name,
  });

  String iso3166_1;
  String name;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso3166_1: json['iso_3166_1'],
        name: json['name'],
      );
}

class SpokenLanguage {
  SpokenLanguage({
    this.englishName,
    this.iso639_1,
    this.name,
  });

  String englishName;
  String iso639_1;
  String name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json['english_name'],
        iso639_1: json['iso_639_1'],
        name: json['name'],
      );
}
