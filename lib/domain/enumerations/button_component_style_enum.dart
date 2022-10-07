//Flutter imports:
import 'package:flutter/material.dart';

//Project imports:
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';

//Enum for the background color of the button
enum ButtonComponentStyle {
  primary,
  secondary,
  canceled,
  accepted,
}

extension ColorExtension on ButtonComponentStyle {
  Color get getStyleBackgroundColor {
    switch (this) {
      case ButtonComponentStyle.primary:
        return colorPrimary;
      case ButtonComponentStyle.secondary:
        return colorSecondary;
      case ButtonComponentStyle.canceled:
        return colorError;
      case ButtonComponentStyle.accepted:
        return colorGreen;
    }
  }

  Color get getStyleTextColor {
    return colorWhite;
  }
}