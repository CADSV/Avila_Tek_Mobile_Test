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
import 'package:avila_tek_test/application/bloc/popular_actors/popular_actors_bloc.dart';
import 'package:avila_tek_test/domain/models/actors/popular_actors_model.dart';
import 'package:avila_tek_test/domain/services/calculate_movie_rating_percentage_service.dart';

//Its the main page of the app.
class PopularActorsPage extends StatefulWidget {
  const PopularActorsPage({Key? key}) : super(key: key);


  @override
  _PopularActorsPageState createState() => _PopularActorsPageState();
}

class _PopularActorsPageState extends State<PopularActorsPage> {
  // ignore: unused_field
  static const routeName = '/popular_actors';

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
      create: (context) => PopularActorsBloc(),
      child: BlocBuilder<PopularActorsBloc, PopularActorsState>(
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
    title: const Text('Popular Actors', style: TextStyle(color: colorBlack, fontSize: 24, fontWeight: FontWeight.bold)),
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
  Widget _body(BuildContext context, PopularActorsState state) {

    if(state is PopularActorsStateInitial) {
      context.read<PopularActorsBloc>().add(PopularActorsEventFetchBasicData(context: context));
    }

    return Stack(
      children: [
        if(state is! PopularActorsStateInitial)  _popularActorsStreamBuilder(context),
        if(state is PopularActorsStateInitial || state is PopularActorsStateLoading) const LoadingComponent(),
      ],
    );
  }


  //StreamBuilder for the PopularActors Page
  Widget _popularActorsStreamBuilder(BuildContext builderContext) => StreamBuilder<List<Actor>>(
    stream: builderContext.read<PopularActorsBloc>().popularActorsStream,
    builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {

      if(snapshot.hasData) {
        return _popularActorsRenderView(context, snapshot.data!);
      } 

      return const LoadingComponent();
    }
  );


  //Widget for the PopularActors Page
  Widget _popularActorsRenderView(BuildContext context, List<Actor> actorsList) => 
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
        children: List.generate(actorsList.length + 2, (index)  {
          if(index >= actorsList.length) {
            if(_isLoading) _fetchNewActors(context, actorsList);
            return const Center(child: LoadingComponent());

          } else {

          return GestureDetector(
            onTap: ()=> context.read<PopularActorsBloc>().add(PopularActorsEventNavigateTo('/actor', actorsList[index].id.toString())),
              child: SizedBox(
                height: index % 2 != 0 ?  250 :  140,
                child: CardComponent(
                  title: actorsList[index].name,
                  imagePath: actorsList[index].profilePath,
                  cardId: actorsList[index].id!.toString(),
                ),
              ));
          }
        }),
      ),
    );


    void _fetchNewActors(BuildContext context, List<Actor> actorsList){
      context.read<PopularActorsBloc>().add(PopularActorsEventFetchMoreActors(actorsList, context));
      _isLoading = false;
    }



}
