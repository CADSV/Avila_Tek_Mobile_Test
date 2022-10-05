//Package imports:
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';
import 'package:flutter/material.dart';

//Project imports:


///BaseUIComponent: Class that manages the UI base page.
// ignore: must_be_immutable
class BaseUIComponent extends StatefulWidget {
  PreferredSizeWidget? appBar;
  final Widget body;
  Color? backgroundColor;
  Widget? bottomNavigationBar;
  Widget? floatingAcctionButton;
  Widget? drawer;
  Key? scaffoldKey;

  BaseUIComponent({Key? key,
    this.appBar,
    required this.body,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingAcctionButton,
    this.drawer,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BaseUIComponent();
}
class _BaseUIComponent extends State<BaseUIComponent> {
  @override
  Widget build(BuildContext context) {
    final Color bgColor = widget.backgroundColor ?? colorWhite;
    return Scaffold(
        drawer: widget.drawer,
        appBar: widget.appBar,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(child: widget.body)),
        backgroundColor: bgColor,
        bottomNavigationBar: widget.bottomNavigationBar,
        floatingActionButton: widget.floatingAcctionButton,
        key: widget.scaffoldKey,
    );
  }
}
