//Flutter imports
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports
import 'package:avila_tek_test/infraestructure/core/constants/text_constants.dart';
import 'package:avila_tek_test/infraestructure/ui/components/dialog_component.dart';
import 'package:avila_tek_test/infraestructure/core/navigator_manager.dart';
import 'package:avila_tek_test/application/use_cases/actor/get_actor_info_use_case.dart';
import 'package:avila_tek_test/domain/models/actors/actor_model.dart';
part 'actor_event.dart';
part 'actor_state.dart';

class ActorBloc extends Bloc<ActorEvent, ActorState> {

  //Here the StreamController can be a state or a DomainModel
  final _actorStreamController = StreamController<ActorModel>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager = NavigatorServiceContract.get();

  final GetActorInfoUseCaseContract _getActorInfoUseCase = GetActorInfoUseCaseContract.get();

   //Constructor
  //You have to declare the StateInitial as the first state
  ActorBloc() : super(ActorStateInitial()){
    on<ActorEventFetchBasicData>(_fetchBasicActorDataEventToState);
    on<ActorEventNavigateTo>(_navigateToEventToState);
  }


  //Getters
  Stream<ActorModel> get actorStream => _actorStreamController.stream;


  //Methods


   ///This method is called when the event is [ActorEventNavigateToWith]
  ///It navigates to the specified page.
  void _navigateToEventToState(ActorEventNavigateTo event, Emitter<ActorState> emit) async {
    _dispose();
    _navigatorManager.navigateTo(event.routeName, arguments: event.arguments);
  }



  ///This method is called when the event [ActorEventFetchBasicData] is called
  ///It fetches the basic data of an actor
  void _fetchBasicActorDataEventToState(ActorEventFetchBasicData event, Emitter<ActorState> emit) async {
    emit(ActorStateLoading());

    var response =  await _getActorInfoUseCase.run(event.actorId); //Execute the use case

    if(response != null){
      var actorResponse =  getActorModelFromJson(response); //Parse the response to a DomainModel


      _actorStreamController.sink.add(actorResponse); //Add the list of movies to the stream

    } else {
      _showDialog(event.context, TextConstant.sorry.text, TextConstant.errorOcurred.text);
    }

    emit(ActorStateHideLoading());
  }




  //Private Methods:
  void _dispose(){
    _actorStreamController.close();
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