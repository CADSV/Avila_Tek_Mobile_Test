//Flutter imports
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports
import 'package:avila_tek_test/infraestructure/core/constants/text_constants.dart';
import 'package:avila_tek_test/infraestructure/ui/components/dialog_component.dart';
import 'package:avila_tek_test/infraestructure/core/navigator_manager.dart';
import 'package:avila_tek_test/application/use_cases/movies/get_movies_feed_use_case.dart';
import 'package:avila_tek_test/domain/models/movies/popular_movies_model.dart';
part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {

  //Here the StreamController can be a state or a DomainModel
  final _feedStreamController = StreamController<List<MovieModel>>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager = NavigatorServiceContract.get();
  final GetMoviesFeedUseCaseContract _getMoviesFeedUseCase = GetMoviesFeedUseCaseContract.get();

   //Constructor
  //You have to declare the StateInitial as the first state
  FeedBloc() : super(FeedStateInitial()){
    on<FeedEventFetchBasicData>(_fetchBasicFeedDataEventToState);
    on<FeedEventNavigateTo>(_navigateToEventToState);
    on<FeedEventFetchMoreMovies>(_fetchMoreMoviesEventToState);
  }

  //Variables

  String _pageNumber = '1'; //This is the page number of the feed response. Starts in 1
  bool _fetchingData = false; //This is a flag to know if the bloc is fetching data or not

  //Getters
  Stream<List<MovieModel>> get feedStream => _feedStreamController.stream;
  bool get fetchingData => _fetchingData;


  //Setters
  set fetchingData(bool value) => _fetchingData = value;


  //Methods


   ///This method is called when the event is [FeedEventNavigateToWith]
  ///It navigates to the specified page.
  void _navigateToEventToState(FeedEventNavigateTo event, Emitter<FeedState> emit) async {
    _dispose();
    _navigatorManager.navigateTo(event.routeName, arguments: event.arguments);
  }



  ///This method is called when the event [FeedEventFetchBasicData] is called
  ///It fetches the basic data of the popular movies feed
  void _fetchBasicFeedDataEventToState(FeedEventFetchBasicData event, Emitter<FeedState> emit) async {
    emit(FeedStateLoading());

    var response = await _getMoviesFeedUseCase.run(_pageNumber); //Execute the use case

    if(response != null){
      var popularMoviesResponse =  getPopularMoviesModelFromJson(response); //Parse the response to a DomainModel

      List<MovieModel> moviesList = popularMoviesResponse.results!; //Extract the list of movies from the response

      _pageNumber = (popularMoviesResponse.page! + 1).toString(); //Update the page number for the next request

      fetchingData = false; //Update the fetching data variable

      _feedStreamController.sink.add(moviesList); //Add the list of movies to the stream

    } else {
      _showDialog(event.context, TextConstant.sorry.text, TextConstant.errorOcurred.text);
    }

    emit(FeedStateHideLoading());
  }


  ///This method is called when the event [FeedEventFetchMoreMovies] is called
  ///It fetches more movies for the feed
  ///It adds the new movies to the stream
  void _fetchMoreMoviesEventToState(FeedEventFetchMoreMovies event, Emitter<FeedState> emit) async {

    var response = await _getMoviesFeedUseCase.run(_pageNumber); //Execute the use case

    if(response != null){
      var popularMoviesResponse =  getPopularMoviesModelFromJson(response); //Parse the response to a DomainModel

      List<MovieModel> newMoviesList = event.oldMoviesList; //Add the old movies to the new list

      newMoviesList.addAll(popularMoviesResponse.results!); //Extract the list of movies from the response

      _pageNumber = (popularMoviesResponse.page! + 1).toString(); //Update the page number for the next request

      fetchingData = false; //Update the fetching data variable

      _feedStreamController.sink.add(newMoviesList); //Add the list of movies to the stream

    } else {
      _showDialog(event.context, TextConstant.sorry.text, TextConstant.errorOcurred.text);
    }

  }


  //Private Methods:
  void _dispose(){
    _feedStreamController.close();
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