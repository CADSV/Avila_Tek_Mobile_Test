//Flutter imports
import 'package:avila_tek_test/application/use_cases/actor/get_popular_actors_use_case.dart';
import 'package:get_it/get_it.dart';

//Project imports
import 'package:avila_tek_test/infraestructure/core/repository_manager.dart';
import 'package:avila_tek_test/infraestructure/core/navigator_manager.dart';
import 'package:avila_tek_test/infraestructure/core/context_manager.dart';
import 'package:avila_tek_test/application/use_cases/actor/get_actor_info_use_case.dart';
import 'package:avila_tek_test/application/use_cases/actor/get_actor_movies_use_case.dart';
import 'package:avila_tek_test/application/use_cases/movies/get_movie_credits_use_case.dart';
import 'package:avila_tek_test/application/use_cases/movies/get_movies_feed_use_case.dart';

//Global constants
final getIt = GetIt.instance;

class InjectionManager {
  static void setupInjections() async {
    getIt.registerSingleton<ContextManager>(ContextManager());
    getIt.registerSingleton<RepositoryManager>(RepositoryManager());

    NavigatorServiceContract.inject();

    //USE CASES INJECTION
    GetMoviesFeedUseCaseContract.inject();
    GetMovieCreditsUseCaseContract.inject();
    GetActorInfoUseCaseContract.inject();
    GetActorMoviesUseCaseContract.inject();
    GetPopularActorsUseCaseContract.inject();
  }
}