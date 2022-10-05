//Flutter imports
import 'package:flutter/material.dart';

//Project imports
import 'package:avila_tek_test/infraestructure/ui/components/loading_component.dart';
import 'package:avila_tek_test/infraestructure/ui/feed/feed_page.dart';
import 'package:avila_tek_test/infraestructure/utils/device_util.dart';
import 'package:avila_tek_test/infraestructure/core/routes_manager.dart';
import 'package:avila_tek_test/infraestructure/ui/styles/theme.dart';
import 'package:avila_tek_test/infraestructure/core/context_manager.dart';
import 'package:avila_tek_test/infraestructure/core/injection_manager.dart';
import 'package:avila_tek_test/infraestructure/core/navigator_manager.dart';

//This the main function of the app.
void main() {

  InjectionManager.setupInjections(); //Here we setup the injections

  //FLAVOR

  runApp(const AvilaTekTest());
}

class AvilaTekTest extends StatelessWidget {
  const AvilaTekTest({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    getIt<ContextManager>().context = context;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigatorServiceContract.get().navigatorKey,
      theme: mainTheme(),
      onGenerateRoute: (
        RouteSettings settings,
      ) => RoutesManager.getOnGenerateRoute(settings, arguments: settings.arguments),
      home: _checkInternet(),
    );
  }

  Widget _checkInternet() {
    return FutureBuilder(
      future: DeviceUtil.checkInternetConnection(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!) {
            return FeedPage();
          } else {
            return const CircularProgressIndicator(color: Colors.blue);
            // return NoInternetPage();
          }
        } else {
          return const LoadingComponent();
        }
      },
    );
  }

}