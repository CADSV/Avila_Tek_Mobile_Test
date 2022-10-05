//Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports
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
  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar( backgroundColor: colorPrimary);


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
  Widget _feedStreamBuilder(BuildContext builderContext) => StreamBuilder<String>(
    stream: builderContext.read<FeedBloc>().feedStream,
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

      if(snapshot.hasData) {
        return _feedRenderView(context);
      } 

      return const LoadingComponent();
    }
  );


  //Widget for the Feed Page
  Widget _feedRenderView(BuildContext context) => const Center(child: Text('Feed Page'));

}