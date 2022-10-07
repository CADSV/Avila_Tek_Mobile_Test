//Project imports:
part of 'popular_actors_bloc.dart';

//PopularActorsState: Here we define the states of the PopularActorsBloc.
abstract class PopularActorsState {}

class PopularActorsStateInitial extends PopularActorsState {}

class PopularActorsStateLoading extends PopularActorsState {}

class PopularActorsStateHideLoading extends PopularActorsState {}



