// ignore_for_file: use_key_in_widget_constructors
//Flutter imports:
import 'package:flutter/material.dart';

//Project imports:
import 'package:avila_tek_test/infraestructure/ui/feed/feed_page.dart';
import 'package:avila_tek_test/infraestructure/core/constants/images_constants.dart';
import 'package:avila_tek_test/infraestructure/ui/components/base_ui_component.dart';
import 'package:avila_tek_test/infraestructure/ui/components/button_component.dart';
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';
import 'package:avila_tek_test/infraestructure/ui/utils/reusable_widgets.dart';
import 'package:avila_tek_test/domain/enumerations/button_component_style_enum.dart';


//NoInternetPage: This is the page that will be shown when the user has no internet connection starting the app.
class NoInternetPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return BaseUIComponent(
      body: _renderBody(context),
      appBar: _renderAppBar(context),
    );
  }


   ///Widget AppBar
  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar( 
    backgroundColor: colorPrimary,
    title: const Text('Avila Tek Test', style: TextStyle(fontWeight: FontWeight.w700),),
    centerTitle: true,
  );


  Widget _renderBody(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment:  CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      renderImageView(context, ImagesConstant.noInternet.image),
      _renderRegisterButton(context),
    ],
  );
  }


  Widget _renderRegisterButton(BuildContext context) => SizedBox(
    width: MediaQuery.of(context).size.width * 0.7,
    child: ButtonComponent(
      title: 'Load again',
      style: ButtonComponentStyle.primary,
      actionButton: () {
        Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (BuildContext routeContext) => const FeedPage()),
              );
      } ,
    ));


}