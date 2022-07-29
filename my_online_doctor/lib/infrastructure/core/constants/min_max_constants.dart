import 'package:flutter/material.dart';

const double marginLat = 16.0;
const double marginTop = 8.0;
const EdgeInsets generalMarginView = EdgeInsets.only(left: marginLat, right: marginLat, top: marginTop, bottom: marginTop);


///MinMaxConstant: Enum for Min or Max for inputs
enum MinMaxConstant {
  minLengthEmail,
  maxLengthEmail,
  minLengthName,
  maxLengthName,
  minLengthPassword,
  maxLengthPassword,
  minLengthPhone,
  maxLengthPhone,

}

extension MinMaxConstantExtension on MinMaxConstant {

  int get value {

    switch(this) {
      case MinMaxConstant.minLengthEmail:
        return 5;

      case MinMaxConstant.maxLengthEmail:
        return 255;

      case MinMaxConstant.minLengthName:
        return 3;

      case MinMaxConstant.maxLengthName:
        return 20;

      case MinMaxConstant.minLengthPassword:
        return 8;

      case MinMaxConstant.maxLengthPassword:
        return 12;
      
      case MinMaxConstant.minLengthPhone:
        return 7;

      case MinMaxConstant.maxLengthPhone:
        return 7;

    }
  }

}