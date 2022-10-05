//Flutter imports
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports
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
    on<FeedEventNavigateToWith>(_navigateToWithEventToState);
  }

  //Variables

  String _pageNumber = '1'; //This is the page number of the feed response. Starts in 1

  //Getters
  Stream<List<MovieModel>> get feedStream => _feedStreamController.stream;


  //Methods

  ///This method is called when the event [FeedEventFetchBasicData] is called
  ///It fetches the basic data of the popular movies feed
  void _fetchBasicFeedDataEventToState(FeedEventFetchBasicData event, Emitter<FeedState> emit) async {
    emit(FeedStateLoading());

    var response = await _getMoviesFeedUseCase.run(_pageNumber);

    if(response != null){
      var popularMoviesResponse =  getPopularMoviesModelFromJson(response);

      List<MovieModel> moviesList = popularMoviesResponse.results!;

      _pageNumber = (popularMoviesResponse.page! + 1).toString();

      _feedStreamController.sink.add(moviesList);

    } else {

      emit(FeedStateError());
    }

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