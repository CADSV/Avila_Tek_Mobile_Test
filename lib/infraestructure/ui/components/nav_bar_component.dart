//Flutter imports:
import 'package:flutter/material.dart';

//Project imports:
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
          const ListTile(
            leading: Icon(Icons.movie),
            title: Text('Latest Movies'),
            iconColor: colorPrimary,
          ),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Actors'),
            iconColor: colorPrimary,
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            iconColor: colorPrimary,
          ),
        ],
      ),
    );

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

