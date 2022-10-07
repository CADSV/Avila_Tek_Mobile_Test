//Flutter imports:
import 'package:flutter/material.dart';

//Project imports:
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';


///ReturnButtonComponent: Class that represents the return button widget component at the top of the screen.
class ReturnButtonComponent extends StatelessWidget {

  final IconData? icon;

  const ReturnButtonComponent({
    Key? key,
    this.icon,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: colorPrimary,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(0)
            ),
            child: Icon(
              icon ?? Icons.chevron_left,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            ),
        ),
        ],
      );
}
