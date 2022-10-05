//Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports
import 'package:avila_tek_test/application/bloc/feed/feed_bloc.dart';

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
          return const CircularProgressIndicator(color: Colors.blue);
          // return BaseUIComponent(
          //   appBar: _renderAppBar(context),
          //   body: _body(context, state),
          //   bottomNavigationBar: _renderBottomNavigationBar(context),
          // );
        },
      ),
    );
  }

}