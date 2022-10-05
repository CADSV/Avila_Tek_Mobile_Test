abstract class MovieQueryProviderContract {

  static MovieQueryProviderContract inject() => _MovieQueryProvider();

  Future getMoviesFeed();

}

enum MovieQueryProviderError {
  unauthorized,
  internalError,
  noMoviesFound,
}


class _MovieQueryProvider extends MovieQueryProviderContract {

  @override
  Future getMoviesFeed() async {
    
  }
}