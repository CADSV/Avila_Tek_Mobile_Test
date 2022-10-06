//Flutter imports
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports
import 'package:avila_tek_test/infraestructure/ui/components/card_component.dart';
import 'package:avila_tek_test/infraestructure/ui/components/nav_bar_component.dart';
import 'package:avila_tek_test/infraestructure/ui/components/loading_component.dart';
import 'package:avila_tek_test/infraestructure/ui/components/base_ui_component.dart';
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';
import 'package:avila_tek_test/application/bloc/feed/feed_bloc.dart';
import 'package:avila_tek_test/domain/models/movies/popular_movies_model.dart';

//Its the main page of the app.
class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);


  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  // ignore: unused_field
  static const routeName = '/feed';

  // ignore: prefer_const_constructors_in_immutables

  //Controllers
  final _scrollController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false; //for the infinite scroll


  @override
  void initState(){
    super.initState();

    _scrollController.addListener((){
      if(_scrollController.position.maxScrollExtent  == _scrollController.offset) {
        setState(() {
          _isLoading = true;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy:  false,
      create: (context) => FeedBloc(),
      child: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          return BaseUIComponent(
            scaffoldKey: scaffoldKey,
            appBar: _renderAppBar(context),
            body: _body(context, state),
            drawer: const NavBar(),
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
    leading: IconButton(
      color: colorPrimary,
      iconSize: 30,
      icon: const Icon(Icons.menu),
      onPressed: (){
        if(scaffoldKey.currentState!.isDrawerOpen){
              scaffoldKey.currentState!.closeDrawer();
              //close drawer, if drawer is open
        }else{
              scaffoldKey.currentState!.openDrawer();
              //open drawer, if drawer is closed
        }
      },
    ),
  );


   //Widget Body
  Widget _body(BuildContext context, FeedState state) {

    if(state is FeedStateInitial) {
      context.read<FeedBloc>().add(FeedEventFetchBasicData(context: context));
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
        controller: _scrollController,
        crossAxisCount: 2,
        shrinkWrap: true,
        childAspectRatio: 0.72,

        mainAxisSpacing: 16,
        crossAxisSpacing: 16,

        scrollDirection: Axis.vertical,
        children: List.generate(moviesList.length + 2, (index)  {
          if(index >= moviesList.length) {
            if(_isLoading) _fetchNewMovies(context, moviesList);
            return const Center(child: LoadingComponent());

          } else {

          return GestureDetector(
            onTap: ()=> context.read<FeedBloc>().add(FeedEventNavigateTo('/movieCredit', moviesList[index])),
              child: SizedBox(
                height: index % 2 != 0 ?  250 :  140,
                child: CardComponent(
                  title: moviesList[index].title,
                  subtitle: '${(moviesList[index].voteAverage!*10).toStringAsFixed(0)}% User Score',
                  imagePath: moviesList[index].posterPath,
                  cardId: moviesList[index].id!.toString(),
                ),
              ));
          }
        }),
      ),
    );


    void _fetchNewMovies(BuildContext context, List<MovieModel> moviesList){
      context.read<FeedBloc>().add(FeedEventFetchMoreMovies(moviesList, context));
      _isLoading = false;
    }



}
