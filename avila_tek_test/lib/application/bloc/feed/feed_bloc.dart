//Flutter imports
import 'dart:async';
import 'package:avila_tek_test/application/use_cases/movies/get_movies_feed_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports
import 'package:avila_tek_test/infraestructure/core/navigator_manager.dart';
part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {

  //Here the StreamController can be a state or a DomainModel
  final _feedStreamController = StreamController<String>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager = NavigatorServiceContract.get();
  final GetMoviesFeedUseCaseContract _getMoviesFeedUseCase = GetMoviesFeedUseCaseContract.get();

   //Constructor
  //You have to declare the StateInitial as the first state
  FeedBloc() : super(FeedStateInitial()){
    on<FeedEventFetchBasicData>(_fetchBasicFeedDataEventToState);
    on<FeedEventNavigateToWith>(_navigateToWithEventToState);
  }

  //Getters
  Stream<String> get feedStream => _feedStreamController.stream;


  //Methods

  ///This method is called when the event [FeedEventFetchBasicData] is called
  ///It fetches the basic data of the feed
  void _fetchBasicFeedDataEventToState(FeedEventFetchBasicData event, Emitter<FeedState> emit) async {
    emit(FeedStateLoading());

    var response = await _getMoviesFeedUseCase.run();
    //Here we fetch the data
    //Here we emit the state
    emit(FeedStateHideLoading());
  }


  ///This method is called when the event is [FeedEventNavigateToWith]
  ///It navigates to the specified page.
  void _navigateToWithEventToState(FeedEventNavigateToWith event, Emitter<FeedState> emit) async {
    _dispose();
    _navigatorManager.navigateToWithReplacement(event.routeName, arguments: event.arguments);
  }


  //Private Methods:
  
   void _dispose(){
    _feedStreamController.close();
  }

}