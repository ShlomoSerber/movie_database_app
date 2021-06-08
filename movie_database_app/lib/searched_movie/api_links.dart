getSMovieLink(String query, int page) {
  String sMovieLink =
      'https://api.themoviedb.org/3/search/movie?api_key=0e685fd77fb3d76874a3ac26e0db8a4b&query=$query&page=$page';
  return sMovieLink;
}

const String imageLink = 'https://image.tmdb.org/t/p/w500';
