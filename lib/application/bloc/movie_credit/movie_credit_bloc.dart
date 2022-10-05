//Flutter imports
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports
import 'package:avila_tek_test/domain/models/movies/movie_credits_model.dart';
import 'package:avila_tek_test/infraestructure/core/constants/text_constants.dart';
import 'package:avila_tek_test/infraestructure/ui/components/dialog_component.dart';
import 'package:avila_tek_test/infraestructure/core/navigator_manager.dart';
part 'movie_credit_event.dart';
part 'movie_credit_state.dart';

class MovieCreditBloc extends Bloc<MovieCreditEvent, MovieCreditState> {

  //Here the StreamController can be a state or a DomainModel
  final _movieCreditStreamController = StreamController<List<MovieCast>>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager = NavigatorServiceContract.get();

   //Constructor
  //You have to declare the StateInitial as the first state
  MovieCreditBloc() : super(MovieCreditStateInitial()){
    on<MovieCreditEventFetchBasicData>(_fetchBasicMovieCreditDataEventToState);
    on<MovieCreditEventNavigateToWith>(_navigateToWithEventToState);
  }

 //Getters
  Stream<List<MovieCast>> get movieCreditStream => _movieCreditStreamController.stream;


  //Methods


   ///This method is called when the event is [MovieCreditEventNavigateToWith]
  ///It navigates to the specified page.
  void _navigateToWithEventToState(MovieCreditEventNavigateToWith event, Emitter<MovieCreditState> emit) async {
    _dispose();
    _navigatorManager.navigateToWithReplacement(event.routeName, arguments: event.arguments);
  }


  ///This method is called when the event [MovieCreditEventFetchBasicData] is called
  ///It fetches the data of the movie credit
  void _fetchBasicMovieCreditDataEventToState(MovieCreditEventFetchBasicData event, Emitter<MovieCreditState> emit) async {
    emit(MovieCreditStateLoading());

    var response = null;// await _getMoviesMovieCreditUseCase.run(); //Execute the use case

    if(response != null){
      var movieCreditResponse =  getMovieCreditModelFromJson(response); //Parse the response to a DomainModel

      List<MovieCast> movieCast = movieCreditResponse.cast!; //Extract the list of movies from the response

      _movieCreditStreamController.sink.add(movieCast); //Add the list of movies to the stream

    } else {
      _showDialog(event.context, TextConstant.sorry.text, TextConstant.errorOcurred.text);
    }

    emit(MovieCreditStateHideLoading());
  }



  //Private methods:

  void _dispose(){
    _movieCreditStreamController.close();
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