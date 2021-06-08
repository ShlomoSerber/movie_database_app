getPMovieLink(int pageNumber) {
  String pMovieLink =
      'https://api.themoviedb.org/3/movie/popular?api_key=0e685fd77fb3d76874a3ac26e0db8a4b&language=en-US&page=$pageNumber';
  return pMovieLink;
}

const String imageLink = 'https://image.tmdb.org/t/p/w500';
