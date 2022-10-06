//Project imports
import 'package:avila_tek_test/infraestructure/core/constants/repository_constants.dart';
import 'package:avila_tek_test/infraestructure/core/injection_manager.dart';
import 'package:avila_tek_test/infraestructure/core/repository_manager.dart';

abstract class ActorQueryProviderContract {

  static ActorQueryProviderContract inject() => _ActorQueryProvider();


  Future getActorInfo(String actorId);

}

enum ActorQueryProviderError {
  unauthorized,
  internalError,
  noActorsFound,
}


class _ActorQueryProvider extends ActorQueryProviderContract {


  @override
  Future getActorInfo(String actorId) async {
    final response = await getIt<RepositoryManager>()
    .request(operation: RepositoryConstant.operationGet.key,
    endpoint: RepositoryPathConstant.moviesByActor.path.toString().replaceFirst(RepositoryParameterPathConstant.actorId.path, actorId))
    .catchError((onError) {

      return null;

    });

    return response;
  }
}