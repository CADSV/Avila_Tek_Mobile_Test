//Flutter imports
import 'package:flutter/material.dart';

//Project imports
import 'package:avila_tek_test/infraestructure/ui/feed/feed_page.dart';


///RoutesManager: Class that manages the app routes.
class RoutesManager {
  static Route getOnGenerateRoute(RouteSettings settings, {Object? arguments}) {
    switch (settings.name) {

      case FeedPage.routeName:
        return MaterialPageRoute(builder: (context) => FeedPage());

      default:
        return MaterialPageRoute(builder: (context) => FeedPage());
    }
  }
}