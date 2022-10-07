//Project import:
import 'package:avila_tek_test/infraestructure/core/injection_manager.dart';
import 'package:avila_tek_test/infraestructure/providers/queries/movie/movie_query_provider_contract.dart';

enum MovieCreditsUseCaseError {noMovieCreditsFound }


abstract class GetMovieCreditsUseCaseContract {
  static inject() => getIt.registerSingleton<GetMovieCreditsUseCaseContract>(
      _GetMovieCreditsUseCase());

  static GetMovieCreditsUseCaseContract get() => getIt<GetMovieCreditsUseCaseContract>();

  /// Providers
  MovieQueryProviderContract provider = MovieQueryProviderContract.inject();

  /// Methods
  Future<dynamic> run(String movieId);
}




class _GetMovieCreditsUseCase extends GetMovieCreditsUseCaseContract {

  @override
  Future<dynamic> run(String movieId) async {

    try {
      return provider.getMovieCredits(movieId);

    } on MovieQueryProviderError catch (error) {
      throw error.toUseCaseError();
    }
  }
}


extension _ProviderMapper on MovieQueryProviderError {
  MovieCreditsUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return MovieCreditsUseCaseError.noMovieCreditsFound;
    }
  }
}