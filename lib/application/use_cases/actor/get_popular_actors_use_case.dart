//Project import:
import 'package:avila_tek_test/infraestructure/core/injection_manager.dart';
import 'package:avila_tek_test/infraestructure/providers/queries/actor/actor_query_provider_contract.dart';
import 'package:avila_tek_test/infraestructure/providers/queries/movie/movie_query_provider_contract.dart';

enum PopularActorsUseCaseError {noActorsFound }


abstract class GetPopularActorsUseCaseContract {
  static inject() => getIt.registerSingleton<GetPopularActorsUseCaseContract>(
      _GetPopularActorsUseCase());

  static GetPopularActorsUseCaseContract get() => getIt<GetPopularActorsUseCaseContract>();

  /// Providers
  ActorQueryProviderContract provider = ActorQueryProviderContract.inject();

  /// Methods
  Future<dynamic> run(String actorId);
}




class _GetPopularActorsUseCase extends GetPopularActorsUseCaseContract {

  @override
  Future<dynamic> run(String actorId) async {

    try {
      return provider.getPopularActors(actorId);

    } on MovieQueryProviderError catch (error) {
      throw error.toUseCaseError();
    }
  }
}


extension _ProviderMapper on MovieQueryProviderError {
  PopularActorsUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return PopularActorsUseCaseError.noActorsFound;
    }
  }
}