//Project imports:
part of 'actor_bloc.dart';

//ActorState: Here we define the states of the ActorBloc.
abstract class ActorState {}

class ActorStateInitial extends ActorState {}

class ActorStateLoading extends ActorState {}

class ActorStateHideLoading extends ActorState {}



