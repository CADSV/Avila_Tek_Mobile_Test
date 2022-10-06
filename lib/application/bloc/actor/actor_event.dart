//Project imports:
part of 'actor_bloc.dart';

///ActorEvent: Here we define the events of the ActorBloc.
abstract class ActorEvent {}


class ActorEventFetchBasicData extends ActorEvent {
  final BuildContext context;
  ActorEventFetchBasicData({required this.context});
}

class ActorEventNavigateTo extends ActorEvent {
  final String routeName;
  final Object? arguments;
  ActorEventNavigateTo(this.routeName, this.arguments);
}
