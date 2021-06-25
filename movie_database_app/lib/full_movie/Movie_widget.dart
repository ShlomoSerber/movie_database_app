import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_database_app/MainScreen_widget.dart';
import 'package:movie_database_app/full_movie/Movie_class.dart';
import 'package:movie_database_app/full_movie/api_links.dart';
import 'package:movie_database_app/global_theme/global_theme.dart';
import 'package:movie_database_app/popular_movie/MainPMovie_widget.dart';
import 'package:movie_database_app/searched_movie/SearchButton_widget.dart';
import 'package:movie_database_app/top_rated_movie/MainTRMovie_widget.dart';

class FullMovie extends StatelessWidget {
  FullMovie({this.id});
  final int id;
  double width;
  Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: FutureBuilder(
        future: http.get(
          Uri.parse(
            getMovieLink(id),
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          final Map parsed = json.decode(snapshot.data.body);
          movie = Movie.fromJson(parsed);
          width = MediaQuery.of(context).size.width;

          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: appBarColor,
              title: Center(
                child: Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SearchButton(),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    switch (value) {
                      case 1:
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainTRMovie(),
                          ),
                        );
                        break;
                      case 2:
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPMovie(),
                          ),
                        );
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Top Rated'),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text('Most Popular'),
                      value: 2,
                    )
                  ],
                )
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(width * 0.01),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.02),
                        child: Container(
                          height: width * 0.78,
                          width: width * 0.5,
                          child: Card(
                            color: cardBackgroundColor,
                            shape: cardShape,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: width * 0.02,
                                    right: width * 0.02,
                                    top: width * 0.02,
                                    bottom: width * 0.02,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: cardRadius,
                                    child: movie.posterPath != null
                                        ? Image.network(
                                            imageLink + movie.posterPath)
                                        : Image.asset(
                                            'images/no_image_available.png'),
                                  ),
                                ),
                                Text(
                                  'Runtime: ' +
                                      movie.runtime.toString() +
                                      ' Minutes',
                                  style: TextStyle(
                                    fontSize:
                                        textScaleFactor(scaleFactor: width),
                                    color: textColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: width * 0.02),
                        child: Container(
                          width: width * 0.46,
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: width * 0.01,
                                  ),
                                  child: text(text: 'Status: ' + movie.status),
                                ),
                                releaseDate(releaseDate: movie.releaseDate),
                                divider(),
                                productionCountries(
                                    productionCountries:
                                        movie.productionCountries),
                                spokenLanguages(
                                    spokenLanguages: movie.spokenLanguages),
                                text(
                                    text: 'Original language: ' +
                                        movie.originalLanguage),
                                divider(),
                                text(
                                  text: 'Budget: ' +
                                      NumberFormat.currency(decimalDigits: 0)
                                          .format(movie.budget),
                                ),
                                text(
                                  text: 'Revenue: ' +
                                      NumberFormat.currency(decimalDigits: 0)
                                          .format(movie.revenue),
                                ),
                                divider(),
                                text(text: 'Adult: ' + movie.adult.toString()),
                                genres(genres: movie.genres),
                                divider(),
                                text(
                                    text: 'Popularity: ' +
                                        movie.popularity.toString()),
                                text(
                                    text: 'Rating: ' +
                                        movie.voteAverage.toString()),
                                divider()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(width * 0.01),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: width * 0.01),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              movie.title,
                              style: TextStyle(
                                  fontSize: textScaleFactor(scaleFactor: width),
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        tagline(tagline: movie.tagline),
                        text(text: 'Overview: ' + movie.overview),
                        divider(),
                        productionCompanies(
                            productionCompanies: movie.productionCompanies),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  divider() {
    return Divider(
      height: width * 0.03,
    );
  }

  text({var text}) {
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.01),
      child: Container(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          maxLines: 100,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: textScaleFactor(scaleFactor: width),
            color: textColor,
          ),
        ),
      ),
    );
  }

  releaseDate({String releaseDate}) {
    if (releaseDate.isNotEmpty) {
      return text(text: 'Release date: ' + releaseDate);
    } else {
      Text empty = Text('');
      return empty;
    }
  }

  productionCountries({List<ProductionCountry> productionCountries}) {
    String start = 'Production countries: ';
    ProductionCountry country;
    List<String> countries = [];

    for (var i = 0; i < productionCountries.length; i++) {
      country = productionCountries[i];
      countries.add(country.name);
    }
    return text(text: start + countries.toString());
  }

  spokenLanguages({List<SpokenLanguage> spokenLanguages}) {
    String start = 'Spoken languages: ';
    SpokenLanguage language;
    List<String> languages = [];

    for (var i = 0; i < spokenLanguages.length; i++) {
      language = spokenLanguages[i];
      languages.add(language.englishName);
    }
    return text(text: start + languages.toString());
  }

  genres({List<Genre> genres}) {
    String start = 'Genres: ';
    Genre genre;
    List<String> stringedGenres = [];

    for (var i = 0; i < genres.length; i++) {
      genre = genres[i];
      stringedGenres.add(genre.name);
    }
    return text(text: start + stringedGenres.toString());
  }

  tagline({String tagline}) {
    if (tagline.isNotEmpty) {
      return text(text: '"' + tagline + '"');
    } else {
      Text empty = Text('');
      return empty;
    }
  }

  Widget productionCompanies({List<ProductionCompany> productionCompanies}) {
    ProductionCompany productionCompany;
    List<Image> images = [];

    for (var i = 0; i < productionCompanies.length; i++) {
      productionCompany = productionCompanies[i];
      if (productionCompany.logoPath != null) {
        images.add(Image.network(imageLink + productionCompany.logoPath));
      }
    }
    List<Widget> finalWidget = imagesFormatter(images: images);
    if (finalWidget.length != 0) {
      return Column(
        children: [
          text(text: 'Production companies:'),
          Row(
            children: finalWidget,
          ),
        ],
      );
    } else {
      return text(text: '');
    }
  }

  List<Widget> imagesFormatter({List<Image> images}) {
    List<Container> containers = [];

    for (var i = 0; i < images.length; i++) {
      containers.add(
        Container(
          padding: EdgeInsets.all(width * 0.01),
          alignment: Alignment.centerLeft,
          height: width * 0.13,
          width: width * 0.15,
          child: images[i],
        ),
      );
    }
    return containers;
  }
}
