//Project imports
import 'package:avila_tek_test/infraestructure/core/constants/repository_constants.dart';
import 'package:avila_tek_test/infraestructure/core/injection_manager.dart';
import 'package:avila_tek_test/infraestructure/core/repository_manager.dart';

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
    final response = await getIt<RepositoryManager>()
    .request(operation: RepositoryConstant.operationGet.key, endpoint: RepositoryPathConstant.moviesFeed.path, )
    .catchError((onError) {

      return null;

    });

    return response;
  }
}