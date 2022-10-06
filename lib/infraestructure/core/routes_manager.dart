//Flutter imports
import 'package:flutter/material.dart';

//Project imports
import 'package:avila_tek_test/infraestructure/ui/movie/movie_credit_page.dart';
import 'package:avila_tek_test/infraestructure/ui/feed/feed_page.dart';
import 'package:avila_tek_test/domain/models/movies/popular_movies_model.dart';


///RoutesManager: Class that manages the app routes.
class RoutesManager {
  static Route getOnGenerateRoute(RouteSettings settings, {Object? arguments}) {
    switch (settings.name) {

      case '/feed':
        return MaterialPageRoute(builder: (context) => const FeedPage());

      case '/movieCredits':
        return MaterialPageRoute(builder: (context) => MovieCreditPage(
          movieModel: arguments as MovieModel,
        ));

      default:
        return MaterialPageRoute(builder: (context) => const FeedPage());
    }
  }
}