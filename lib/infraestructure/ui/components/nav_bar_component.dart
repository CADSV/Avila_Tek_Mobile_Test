//Flutter imports:
import 'package:flutter/material.dart';

//Project imports:
import 'package:avila_tek_test/infraestructure/core/constants/text_constants.dart';
import 'package:avila_tek_test/infraestructure/ui/components/dialog_component.dart';
import 'package:avila_tek_test/infraestructure/ui/feed/feed_page.dart';
import 'package:avila_tek_test/infraestructure/ui/popular_actors/popular_actors_page.dart';
import 'package:avila_tek_test/infraestructure/core/constants/images_constants.dart';
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';

///NavBarComponent: Class that manages the navigation bar of the menu.
class NavBar extends StatelessWidget {


  const NavBar({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  <Widget>[
          _navBarHeader(context),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Latest Movies'),
            iconColor: colorPrimary,
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (BuildContext routeContext) => const FeedPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Popular Actors'),
            iconColor: colorPrimary,
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (BuildContext routeContext) => const PopularActorsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            iconColor: colorPrimary,
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext superContext) => DialogComponent(
                    textTitle: TextConstant.sorry.text,
                    textQuestion: TextConstant.pageInConstruction.text,
                  )
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            iconColor: colorPrimary,
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext superContext) => DialogComponent(
                    textTitle: TextConstant.sorry.text,
                    textQuestion: TextConstant.pageInConstruction.text,
                  )
              );
            },
          )
        ],
      ),
    );

    ///_navBarHeader: Method that returns the header of the navigation bar.
    Widget _navBarHeader(BuildContext context) =>
      UserAccountsDrawerHeader(
        accountName: const Text('Carlos Doffiny S-V', style: TextStyle(fontWeight: FontWeight.bold),),
        accountEmail: const Text('email@gmail.com'),
        decoration: BoxDecoration(
          color: colorPrimary,
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
            image: AssetImage(
              ImagesConstant.avilaTek.image,)
          )
        ),
      );
}

