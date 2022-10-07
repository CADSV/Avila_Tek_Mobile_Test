//Project import:
import 'package:avila_tek_test/infraestructure/core/injection_manager.dart';
import 'package:avila_tek_test/infraestructure/providers/queries/actor/actor_query_provider_contract.dart';
import 'package:avila_tek_test/infraestructure/providers/queries/movie/movie_query_provider_contract.dart';

enum ActorInfoUseCaseError {noActorFound }


abstract class GetActorInfoUseCaseContract {
  static inject() => getIt.registerSingleton<GetActorInfoUseCaseContract>(
      _GetActorInfoUseCase());

  static GetActorInfoUseCaseContract get() => getIt<GetActorInfoUseCaseContract>();

  /// Providers
  ActorQueryProviderContract provider = ActorQueryProviderContract.inject();

  /// Methods
  Future<dynamic> run(String actorId);
}




class _GetActorInfoUseCase extends GetActorInfoUseCaseContract {

  @override
  Future<dynamic> run(String actorId) async {

    try {
      return provider.getActorInfo(actorId);

    } on MovieQueryProviderError catch (error) {
      throw error.toUseCaseError();
    }
  }
}


extension _ProviderMapper on MovieQueryProviderError {
  ActorInfoUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return ActorInfoUseCaseError.noActorFound;
    }
  }
}