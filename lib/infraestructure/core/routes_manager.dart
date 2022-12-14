//Flutter imports
import 'package:flutter/material.dart';

//Project imports
import 'package:avila_tek_test/infraestructure/ui/popular_actors/popular_actors_page.dart';
import 'package:avila_tek_test/infraestructure/ui/actor/actor_page.dart';
import 'package:avila_tek_test/infraestructure/ui/movie/movie_credit_page.dart';
import 'package:avila_tek_test/infraestructure/ui/feed/feed_page.dart';
import 'package:avila_tek_test/domain/models/movies/popular_movies_model.dart';
import 'package:avila_tek_test/domain/models/movies/movie_credits_model.dart';


///RoutesManager: Class that manages the app routes.
class RoutesManager {
  static Route getOnGenerateRoute(RouteSettings settings, {Object? arguments}) {
    switch (settings.name) {

      case '/feed':
        return MaterialPageRoute(builder: (context) => const FeedPage());

      case '/movie_credit':
        return MaterialPageRoute(builder: (context) => MovieCreditPage(
          movieModel: arguments as MovieModel,
        ));

      case '/actor':
        return MaterialPageRoute(builder: (context) =>  ActorPage(
          actorId: arguments as String,
        ));

      case '/popular_actors':
        return MaterialPageRoute(builder: (context) => const PopularActorsPage());


      default:
        return MaterialPageRoute(builder: (context) => const FeedPage());
    }
  }
}