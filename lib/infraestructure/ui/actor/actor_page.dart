//Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports:
import 'package:avila_tek_test/infraestructure/ui/components/base_ui_component.dart';
import 'package:avila_tek_test/infraestructure/core/constants/images_constants.dart';
import 'package:avila_tek_test/infraestructure/ui/components/card_component.dart';
import 'package:avila_tek_test/infraestructure/ui/components/loading_component.dart';
import 'package:avila_tek_test/infraestructure/ui/components/return_button_component.dart';
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';
import 'package:avila_tek_test/application/bloc/actor/actor_bloc.dart';
import 'package:avila_tek_test/domain/models/actors/actor_model.dart';
import 'package:avila_tek_test/domain/services/calculate_movie_rating_percentage_service.dart';
import 'package:avila_tek_test/domain/models/movies/popular_movies_model.dart';

///ActorPage: Class that represents the actor page.
class ActorPage extends StatelessWidget {

  static const routeName = '/actor';

  final String actorId;
  const ActorPage({Key? key,
  required this.actorId}) : super(key: key);

    @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy:  false,
      create: (context) => ActorBloc(),
      child: BlocBuilder<ActorBloc, ActorState>(
        builder: (context, state) {
          return BaseUIComponent(
            // appBar: _renderAppBar(context),
            body: _body(context, state),
            // bottomNavigationBar: _renderBottomNavigationBar(context),
          );
        },
      ),
    );
  }


///Widget AppBar
  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar(
    backgroundColor: colorWhite,
  );


   //Widget Body
  Widget _body(BuildContext context, ActorState state) {

    if(state is ActorStateInitial) {
      context.read<ActorBloc>().add(ActorEventFetchBasicData(context: context, actorId: actorId.toString()));
    }

    return Stack(
      children: [
        if(state is! ActorStateInitial)  _actorStreamBuilder(context),
        if(state is ActorStateInitial || state is ActorStateLoading) const LoadingComponent(),
      ],
    );
  }


    //StreamBuilder for the Actor Page
  Widget _actorStreamBuilder(BuildContext builderContext) => StreamBuilder<ActorModel>(
    stream: builderContext.read<ActorBloc>().actorStream,
    builder: (BuildContext context, AsyncSnapshot<ActorModel> snapshot) {

      if(snapshot.hasData) {
        return _actorRenderView(context, snapshot.data!);
      } 

      return const LoadingComponent();
    }
  );


  //Render the view of the actor
  Widget _actorRenderView(BuildContext context, ActorModel actor) =>
  ListView(
    children:  [
      const ReturnButtonComponent(icon: Icons.chevron_left),
      _renderActorProfile(context, actor),
      _renderActorMoviesTitle(),
      if(actor.movies!.isNotEmpty) _rendederActorMovies(context, actor.movies!),
      if(actor.movies!.isEmpty) _renderNoMoviesFound(),
    ],
  );


  //Widget to render the actor profile
  Widget _renderActorProfile(BuildContext context, ActorModel actor) =>
    Container(
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _actorImage(actor),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _actorName(actor),
                _actorBiography(actor),
              ],
            ),
          ),
        ],
      ),
    );


  //Widget to render the actor image
  Widget _actorImage(ActorModel actor) =>
    Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: actor.profilePath != null ?NetworkImage(
              imageUrl + actor.profilePath!,
            ) :
            AssetImage(ImagesConstant.empty.image) as ImageProvider,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );


  //Widget to render the actor name
  Widget _actorName(ActorModel actor) =>
    Text(
      actor.name!,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );


  //Widget to render the actor biography
  Widget _actorBiography(ActorModel actor) =>
    Container(
      margin: const EdgeInsets.only(top: 10, right: 20),
      child: Text(
        actor.biography == null || actor.biography =='' ? 'No biography available' : actor.biography!,
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'Baloo 2'
        ),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
    );


  //Widget to render the actor movies title
  Widget _renderActorMoviesTitle() =>
    Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: const Text(
        'Casted On',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );


  //Widget to render the actor movies
  Widget _rendederActorMovies(BuildContext context, List<MovieModel> movies) =>
    SizedBox(
      height: MediaQuery.of(context).size.height * 0.52,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [ Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.72,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                scrollDirection: Axis.vertical,
                children: List.generate(movies.length, (index)  {

                    return GestureDetector(
                      onTap: ()=> context.read<ActorBloc>().add(ActorEventNavigateTo('/movie_credit', movies[index])),
                        child: CardComponent(
                          title: movies[index].title,
                          subtitle: '${(CalculateMovieRatingPercentageService.getMovieRatingPercentage(movies[index].voteAverage!)).toStringAsFixed(0)}% User Score',
                          imagePath: movies[index].posterPath,
                          cardId: movies[index].id!.toString(),
                        ));
                  }
                ),
              ),
              ),],
            ),
          ),
        ],
      ),
    );


  //Widget to render the no movies found
  Widget _renderNoMoviesFound() =>
    Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        child: const Text(
          'No movies found',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            fontFamily: 'Baloo 2'
          ),
        ),
      ),
    );

}

