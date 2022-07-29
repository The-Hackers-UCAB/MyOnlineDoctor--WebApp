import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';


/// This file is used to manage the different themes of the application.

//Main theme.
ThemeData mainTheme() {
  return ThemeData(
      primaryColor: colorPrimary,
      backgroundColor: colorSecondary,
      errorColor: colorError,
      appBarTheme: AppBarTheme(
          color: colorPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          actionsIconTheme: const IconThemeData(color: Colors.white), toolbarTextStyle: const TextTheme(
              bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              bodyText2: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              headline1: TextStyle(color: Colors.white, fontSize: 16)).bodyText2, titleTextStyle: const TextTheme(
              bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              bodyText2: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              headline1: TextStyle(color: Colors.white, fontSize: 16)).headline6),
      fontFamily: 'Garet Light',
      // iconTheme: IconThemeData(color: colorPrimary),
      toggleableActiveColor: colorPrimary,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        splashColor: colorActive,
        hoverColor: colorActive,
      ),
      textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black, fontSize: 16.0),
          bodyText2: TextStyle(color: Colors.black, fontSize: 14.0),
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          subtitle1: TextStyle(
              color: colorPrimary, fontSize: 16.0, fontWeight: FontWeight.bold),
          subtitle2: TextStyle(color: Colors.black, fontSize: 14.0),
          caption: TextStyle(
              color: colorBlack,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nexa'),
          button: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
      dialogTheme: const DialogTheme(
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: TextStyle(fontSize: 14, color: Colors.white)),
      buttonTheme: ButtonThemeData(
          buttonColor: colorPrimary,
          disabledColor: Colors.grey,
          textTheme: ButtonTextTheme.primary,
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          )), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: colorActive));
}


BoxDecoration boxDecorationDropdown(bool white, bool error) {
  return BoxDecoration(
    color: colorWhite,
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(
        style: BorderStyle.solid,
        color: !error ? colorSecondary : colorError,
        width: 1),
  );
}



InputDecoration boxTextFormFieldDecorationDefault() {
  return InputDecoration(
    // contentPadding: const EdgeInsets.all(8.0),
    enabledBorder: boxBorderTextField(colorSecondary),
    border: boxBorderTextField(colorSecondary),
    focusedBorder: boxBorderTextField(colorPrimary),
    errorBorder: boxBorderTextField(colorError),
    errorStyle: const TextStyle(
        fontSize: 12.0, color: colorError, fontWeight: FontWeight.bold),
  );
}


OutlineInputBorder boxBorderTextField(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      style: BorderStyle.solid,
      color: color,
      width: 1,
    ),
  );
}



TextStyle textStyleAppBar() {
  return const TextStyle(
    color: colorWhite,
    fontSize: 21,
    fontWeight: FontWeight.w600,
    fontFamily: 'Garet Light',
  );
}



TextStyle textStyleFormField(bool primaryColor) {
  return TextStyle(
    color: primaryColor ? colorPrimary : colorBlack,
    fontSize: 17,
    fontWeight: primaryColor ? FontWeight.w500 : FontWeight.w400,
    fontFamily: 'Garet Light',
  );
}