//Flutter imports
import 'package:get_it/get_it.dart';

//Project imports
import 'package:avila_tek_test/infraestructure/core/navigator_manager.dart';
import 'package:avila_tek_test/infraestructure/core/context_manager.dart';

//Global constants
final getIt = GetIt.instance;

class InjectionManager {
  static void setupInjections() async {
    getIt.registerSingleton<ContextManager>(ContextManager());
    // getIt.registerSingleton<RepositoryManager>(RepositoryManager());

    NavigatorServiceContract.inject();
  }
}