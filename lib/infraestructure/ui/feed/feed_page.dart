//Flutter imports
import 'package:avila_tek_test/infraestructure/core/constants/images_constants.dart';
import 'package:avila_tek_test/infraestructure/ui/components/movie_card_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports
import 'package:avila_tek_test/domain/models/movies/popular_movies_model.dart';
import 'package:avila_tek_test/infraestructure/ui/components/loading_component.dart';
import 'package:avila_tek_test/application/bloc/feed/feed_bloc.dart';
import 'package:avila_tek_test/infraestructure/ui/components/base_ui_component.dart';
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';

//Its the main page of the app.
class FeedPage extends StatelessWidget {

  static const routeName = '/feed';

  // ignore: prefer_const_constructors_in_immutables
  FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy:  false,
      create: (context) => FeedBloc(),
      child: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          return BaseUIComponent(
            appBar: _renderAppBar(context),
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
    title: const Text('Latest', style: TextStyle(color: colorBlack, fontSize: 24, fontWeight: FontWeight.bold)),
    centerTitle: true,
    elevation: 0,
  );


   //Widget Body
  Widget _body(BuildContext context, FeedState state) {

    if(state is FeedStateInitial) {
      context.read<FeedBloc>().add(FeedEventFetchBasicData());
    }

    return Stack(
      children: [
        if(state is! FeedStateInitial)  _feedStreamBuilder(context),
        if(state is FeedStateInitial || state is FeedStateLoading) const LoadingComponent(),
      ],
    );
  }


  //StreamBuilder for the Feed Page
  Widget _feedStreamBuilder(BuildContext builderContext) => StreamBuilder<List<MovieModel>>(
    stream: builderContext.read<FeedBloc>().feedStream,
    builder: (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {

      if(snapshot.hasData) {
        return _feedRenderView(context, snapshot.data!);
      } 

      return const LoadingComponent();
    }
  );


  //Widget for the Feed Page
  Widget _feedRenderView(BuildContext context, List<MovieModel> moviesList) => 
    Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        childAspectRatio: 0.72,

        mainAxisSpacing: 16,
        crossAxisSpacing: 16,

        scrollDirection: Axis.vertical,
        children: List.generate(moviesList.length, (index) {
          return GestureDetector(
            // onTap: ()=>onSelectMovie(moviesModel.results![index] as T),
              child: SizedBox(
                height: index % 2 != 0 ?  250 :  140,
                child: MovieCardComponent(movie: moviesList[index]),
              ));
        }),
      ),
    );




    // Column(
    //   children: [
    //     Container(
    //       padding: const EdgeInsets.all(20),
    //       height: MediaQuery.of(context).size.height * 0.38,
    //       width: MediaQuery.of(context).size.width * 0.42,
    //       decoration: BoxDecoration(
    //         color: colorBlack,
    //         borderRadius: BorderRadius.circular(16)
    //       ),
    //       child: Column(
    //         children: [
    //           Image.network(imageUrl + moviesList[0].posterPath!),
    //           Text(moviesList[0].title!, style: const TextStyle(color: colorWhite, fontSize: 18, fontWeight: FontWeight.bold)),
    //         ],
    //       ),
    //     ),
    //   ],
    // );



}

