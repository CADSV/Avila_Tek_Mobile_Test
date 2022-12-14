//Flutter imports
// ignore_for_file: library_private_types_in_public_api
import 'package:avila_tek_test/infraestructure/ui/components/return_button_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports:
import 'package:avila_tek_test/infraestructure/ui/components/card_component.dart';
import 'package:avila_tek_test/infraestructure/ui/components/loading_component.dart';
import 'package:avila_tek_test/infraestructure/core/constants/images_constants.dart';
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';
import 'package:avila_tek_test/infraestructure/ui/components/base_ui_component.dart';
import 'package:avila_tek_test/application/bloc/movie_credit/movie_credit_bloc.dart';
import 'package:avila_tek_test/domain/models/movies/popular_movies_model.dart';
import 'package:avila_tek_test/domain/models/movies/movie_credits_model.dart';
import 'package:avila_tek_test/domain/services/calculate_movie_rating_percentage_service.dart';


class MovieCreditPage extends StatelessWidget {

  final MovieModel movieModel;

  static const routeName = '/movieCredit';

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
      context.read<MovieCreditBloc>().add(MovieCreditEventFetchBasicData(context: context, movieId: movieModel.id.toString()));
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
  Widget _movieCreditRenderView(BuildContext context, List<MovieCast> movieCast) => 
    GestureDetector(
      // onTap: () => _renderMovieCredits(context, movieCast),
      child: Stack(
        children: [
          _backgroundImage(context),
          const ReturnButtonComponent(icon: Icons.close),
          _renderMovieCredits(context, movieCast),
          ],
        ),
    );


  //Widget for the background image
  Widget _backgroundImage(BuildContext context) =>
    Hero(
      tag: movieModel.id.toString(),
      child: Image.network(
        imageUrl + movieModel.posterPath!,
        fit: BoxFit.fill,
        height: double.infinity,
        width: double.infinity,
      ),
    );


  //Widget for the movie credits
  Widget _renderMovieCredits(BuildContext context, List<MovieCast> movieCast) =>
    Column(
      children: [
        Expanded(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _renderMovieTitle(context),
              _renderMovieRating(context),
              _renderMovieTopActors(context, movieCast),
            ],
          )
        )
      ]
    );


  //Widget for the movie title
  Widget _renderMovieTitle(BuildContext context) =>
    Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10, left: 20),
      child: Text(
        movieModel.title!,
        maxLines: 2,
        style: const TextStyle(
          color: colorWhite,
          fontSize: 42,
          fontWeight: FontWeight.bold
        ),
      ),
    );

  
  //Widget for the movie rating
  Widget _renderMovieRating(BuildContext context) =>
    Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10, left: 20),
      child: Text(
        '${(CalculateMovieRatingPercentageService.getMovieRatingPercentage(movieModel.voteAverage!)).toStringAsFixed(0)}% User Score',
        maxLines: 2,
        style: const TextStyle(
          color: colorWhite,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: 'Baloo 2'
        ),
      ),
    );



  //Widget for the movie top actors
  Widget _renderMovieTopActors(BuildContext context, List<MovieCast> movieCast) =>
    SizedBox(
      height: MediaQuery.of(context).size.height * 0.26,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 1,
          shrinkWrap: true,
          childAspectRatio: 1.2,

          mainAxisSpacing: 16,
          crossAxisSpacing: 16,

          scrollDirection: Axis.horizontal,
          children: List.generate(3, (index)  {

            return GestureDetector(
              onTap: ()=> context.read<MovieCreditBloc>().add(MovieCreditEventNavigateTo('/actor', movieCast[index].id.toString())),
                child: CardComponent(
                  title: movieCast[index].name,
                  subtitle: movieCast[index].character,
                  imagePath: movieCast[index].profilePath,
                  cardId: movieCast[index].id.toString(),
                ),
              );
            },
          ),
        ),
      ),
    );

}