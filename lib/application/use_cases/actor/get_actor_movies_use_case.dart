//Project import:
import 'package:avila_tek_test/infraestructure/core/injection_manager.dart';
import 'package:avila_tek_test/infraestructure/providers/queries/actor/actor_query_provider_contract.dart';
import 'package:avila_tek_test/infraestructure/providers/queries/movie/movie_query_provider_contract.dart';

enum ActorMoviesUseCaseError {noActorFound }


abstract class GetActorMoviesUseCaseContract {
  static inject() => getIt.registerSingleton<GetActorMoviesUseCaseContract>(
      _GetActorMoviesUseCase());

  static GetActorMoviesUseCaseContract get() => getIt<GetActorMoviesUseCaseContract>();

  /// Providers
  ActorQueryProviderContract provider = ActorQueryProviderContract.inject();

  /// Methods
  Future<dynamic> run(String actorId);
}




class _GetActorMoviesUseCase extends GetActorMoviesUseCaseContract {

  @override
  Future<dynamic> run(String actorId) async {

    try {
      return provider.getActorMovies(actorId);

    } on MovieQueryProviderError catch (error) {
      throw error.toUseCaseError();
    }
  }
}


extension _ProviderMapper on MovieQueryProviderError {
  ActorMoviesUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return ActorMoviesUseCaseError.noActorFound;
    }
  }
}