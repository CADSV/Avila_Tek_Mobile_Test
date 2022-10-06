//Flutter imports
// ignore_for_file: library_private_types_in_public_api
import 'package:avila_tek_test/domain/models/movies/popular_movies_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports:
import 'package:avila_tek_test/infraestructure/ui/components/loading_component.dart';
import 'package:avila_tek_test/infraestructure/ui/components/base_ui_component.dart';
import 'package:avila_tek_test/application/bloc/movie_credit/movie_credit_bloc.dart';
import 'package:avila_tek_test/domain/models/movies/movie_credits_model.dart';


class MovieCreditPage extends StatelessWidget {

  final MovieModel movieModel;

  static const routeName = '/movieCredits';

  const MovieCreditPage({Key? key,
  required this.movieModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy:  false,
      create: (context) => MovieCreditBloc(),
      child: BlocBuilder<MovieCreditBloc, MovieCreditState>(
        builder: (context, state) {
          return BaseUIComponent(
            body: _body(context, state),
            // bottomNavigationBar: _renderBottomNavigationBar(context),
          );
        },
      ),
    );
  }


   //Widget Body
  Widget _body(BuildContext context, MovieCreditState state) {

    if(state is MovieCreditStateInitial) {
      context.read<MovieCreditBloc>().add(MovieCreditEventFetchBasicData(context: context));
    }

    return Stack(
      children: [
        if(state is! MovieCreditStateInitial)  _movieCreditStreamBuilder(context),
        if(state is MovieCreditStateInitial || state is MovieCreditStateLoading) const LoadingComponent(),
      ],
    );
  }


    //StreamBuilder for the MovieCredit Page
  Widget _movieCreditStreamBuilder(BuildContext builderContext) => StreamBuilder<List<MovieCast>>(
    stream: builderContext.read<MovieCreditBloc>().movieCreditStream,
    builder: (BuildContext context, AsyncSnapshot<List<MovieCast>> snapshot) {

      if(snapshot.hasData) {
        return _movieCreditRenderView(context, snapshot.data!);
      } 

      return const LoadingComponent();
    }
  );


    //Widget for the Feed Page
  Widget _movieCreditRenderView(BuildContext context, List<MovieCast> moviesList) => 
    Text('Movie Credit Page');


}