//Flutter imports:
import 'package:flutter/material.dart';

//Project imports:
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';
import 'package:avila_tek_test/domain/enumerations/button_component_style_enum.dart';


///ButtonComponent: Button Widget for different action buttons
class ButtonComponent extends StatelessWidget {
  final ButtonComponentStyle style;
  final String title;
  final VoidCallback? actionButton;


  const ButtonComponent({
    Key? key,
    this.style = ButtonComponentStyle.primary,
    required this.title,
    this.actionButton}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      TextButton(
          style: _buttonStyle(),
          onPressed: actionButton,
          child: Center(child: Text(title, style: _textStyle(),)));

  ButtonStyle _buttonStyle() => TextButton.styleFrom(
    backgroundColor: style.getStyleBackgroundColor,
    primary: style.getStyleTextColor,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
      side: const BorderSide(
        color: Colors.transparent,
      ),),
    padding: const EdgeInsets.only(
      top: 5.0,
      bottom: 5.0,
    ),);

  TextStyle _textStyle() =>  const TextStyle(
      fontFamily:  'Baloo',
      fontSize: 19,
      color: colorWhite);

}