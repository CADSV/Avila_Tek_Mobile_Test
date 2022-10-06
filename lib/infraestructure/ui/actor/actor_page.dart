//Flutter imports:
import 'package:avila_tek_test/domain/models/actors/actor_model.dart';
import 'package:avila_tek_test/infraestructure/ui/components/loading_component.dart';
import 'package:avila_tek_test/infraestructure/ui/components/return_button_component.dart';
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports:
import 'package:avila_tek_test/infraestructure/ui/components/base_ui_component.dart';
import 'package:avila_tek_test/application/bloc/actor/actor_bloc.dart';
import 'package:avila_tek_test/domain/models/movies/movie_credits_model.dart';

///ActorPage: Class that represents the actor page.
class ActorPage extends StatelessWidget {

  static const routeName = '/actor';

  final MovieCast actor;
  const ActorPage({Key? key,
  required this.actor}) : super(key: key);

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
      context.read<ActorBloc>().add(ActorEventFetchBasicData(context: context, actorId: actor.id.toString()));
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
  Stack(
    children: const [
      ReturnButtonComponent(icon: Icons.chevron_left),
      // _actorImage(actor),
      // _actorName(actor),
      // _actorBiography(actor),
    ],
  );

    //Widget for the return button at the top of the page


}

