//Project imports:
part of 'actor_bloc.dart';

///ActorEvent: Here we define the events of the ActorBloc.
abstract class ActorEvent {}


class ActorEventFetchBasicData extends ActorEvent {
  final BuildContext context;
  final String actorId;
  ActorEventFetchBasicData({required this.context, required this.actorId});
}

class ActorEventNavigateTo extends ActorEvent {
  final String routeName;
  final Object? arguments;
  ActorEventNavigateTo(this.routeName, this.arguments);
}
