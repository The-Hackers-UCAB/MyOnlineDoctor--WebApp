import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

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
      fontFamily:  'Garet Light',
      fontSize: 19,
      color: colorWhite);

}