//Project imports:
part of 'popular_actors_bloc.dart';

///PopularActorsEvent: Here we define the events of the PopularActorsBloc.
abstract class PopularActorsEvent {}


class PopularActorsEventFetchBasicData extends PopularActorsEvent {
  final BuildContext context;
  PopularActorsEventFetchBasicData({required this.context});
}

class PopularActorsEventNavigateTo extends PopularActorsEvent {
  final String routeName;
  final Object? arguments;
  PopularActorsEventNavigateTo(this.routeName, this.arguments);
}

class PopularActorsEventFetchMoreActors extends PopularActorsEvent {
  final List<Actor> oldActorsList;
  final BuildContext context;
  PopularActorsEventFetchMoreActors(this.oldActorsList, this.context);
}
