//Flutter imports
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:avila_tek_test/application/use_cases/actor/get_popular_actors_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports
import 'package:avila_tek_test/infraestructure/core/constants/text_constants.dart';
import 'package:avila_tek_test/infraestructure/ui/components/dialog_component.dart';
import 'package:avila_tek_test/infraestructure/core/navigator_manager.dart';
import 'package:avila_tek_test/domain/models/actors/popular_actors_model.dart';
part 'popular_actors_event.dart';
part 'popular_actors_state.dart';

class PopularActorsBloc extends Bloc<PopularActorsEvent, PopularActorsState> {

  //Here the StreamController can be a state or a DomainModel
  final _popularActorsStreamController = StreamController<List<Actor>>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager = NavigatorServiceContract.get();

  final GetPopularActorsUseCaseContract _getPopularActorsUseCase = GetPopularActorsUseCaseContract.get();

   //Constructor
  //You have to declare the StateInitial as the first state
  PopularActorsBloc() : super(PopularActorsStateInitial()){
    on<PopularActorsEventFetchBasicData>(_fetchBasicPopularActorsDataEventToState);
    on<PopularActorsEventNavigateTo>(_navigateToEventToState);
    on<PopularActorsEventFetchMoreActors>(_fetchMorePopularActorsDataEventToState);
  }


  //Variables

  String _pageNumber = '1'; //

  //Getters
  Stream<List<Actor>> get popularActorsStream => _popularActorsStreamController.stream;


  //Methods


   ///This method is called when the event is [PopularActorsEventNavigateToWith]
  ///It navigates to the specified page.
  void _navigateToEventToState(PopularActorsEventNavigateTo event, Emitter<PopularActorsState> emit) async {
    _dispose();
    _navigatorManager.navigateTo(event.routeName, arguments: event.arguments);
  }



  ///This method is called when the event [PopularActorsEventFetchBasicData] is called
  ///It fetches the basic data of popular actors
  void _fetchBasicPopularActorsDataEventToState(PopularActorsEventFetchBasicData event, Emitter<PopularActorsState> emit) async {
    emit(PopularActorsStateLoading());

    var response =  await _getPopularActorsUseCase.run(_pageNumber); //Execute the use case


    if(response != null) {

      var popularActorsResponse =  getPopularActorsModelFromJson(response); //Parse the response to a DomainModel

      List<Actor> popularActorsList = popularActorsResponse.results!; //Extract the list of actors from the response


      _pageNumber = (popularActorsResponse.page! + 1).toString(); //Update the page number for the next request

      _popularActorsStreamController.sink.add(popularActorsList); //Add the list of actors to the stream

    } else {
      _showDialog(event.context, TextConstant.sorry.text, TextConstant.errorOcurred.text);
    }

    emit(PopularActorsStateHideLoading());
  }
  


  ///This method is called when the event [PopularActorsEventFetchMoreActors] is called
  ///It fetches more popular actors
  void _fetchMorePopularActorsDataEventToState(PopularActorsEventFetchMoreActors event, Emitter<PopularActorsState> emit) async {

    var response = await _getPopularActorsUseCase.run(_pageNumber); //Execute the use case

    if(response != null){
      var popularActorsResponse =  getPopularActorsModelFromJson(response); //Parse the response to a DomainModel

      List<Actor> newPopularActorsList = event.oldActorsList; //Add the old actors to the new list

      newPopularActorsList.addAll(popularActorsResponse.results!); //Extract the list of actors from the response

      _pageNumber = (popularActorsResponse.page! + 1).toString(); //Update the page number for the next request

      _popularActorsStreamController.sink.add(newPopularActorsList); //Add the list of actors to the stream

    } else {
      _showDialog(event.context, TextConstant.sorry.text, TextConstant.errorOcurred.text);
    }

  }



  //Private Methods:
  void _dispose(){
    _popularActorsStreamController.close();
  }

  void _showDialog(BuildContext context, String title, String message) async {
    await showDialog(
        context: context,
        builder: (BuildContext superContext) => DialogComponent(
          textTitle: title,
          textQuestion: message,
        )
    );
  }

}