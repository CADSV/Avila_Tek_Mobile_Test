//Project import:
import 'package:avila_tek_test/infraestructure/core/injection_manager.dart';
import 'package:avila_tek_test/infraestructure/providers/queries/movie/movie_query_provider_contract.dart';

enum MovieFeedUseCaseError {noMoviesFound }


abstract class GetMoviesFeedUseCaseContract {
  static inject() => getIt.registerSingleton<GetMoviesFeedUseCaseContract>(
      _GetMoviesFeedUseCase());

  static GetMoviesFeedUseCaseContract get() => getIt<GetMoviesFeedUseCaseContract>();

  /// Providers
  MovieQueryProviderContract provider = MovieQueryProviderContract.inject();

  /// Methods
  Future<dynamic> run();
}




class _GetMoviesFeedUseCase extends GetMoviesFeedUseCaseContract {

  @override
  Future<dynamic> run() async {

    try {
      
      return provider.getMoviesFeed();

    } on MovieQueryProviderError catch (error) {
      throw error.toUseCaseError();
    }
  }
}


extension _ProviderMapper on MovieQueryProviderError {
  MovieFeedUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return MovieFeedUseCaseError.noMoviesFound;
    }
  }
}