//Package imports
import 'package:flutter/material.dart';

//Here we add the flavors that we have (Preferly in mayus, but only in this enum)
enum Flavor {
  PRODUCTION
  } 

extension FlavorEnum on Flavor {

  //flavor's url
  String get url {
    switch (this) {
      case Flavor.PRODUCTION:
        return 'https://myonlinedoctor-main.herokuapp.com/';
      default:
        return 'https://myonlinedoctor-main.herokuapp.com/';
    }
  }

  //flavor's color (used in the banner app)
  Color get color {
    switch (this) {
      default:
        return Colors.black;
    }
  }
}

///FlavorManager: Class that manages the backend flavors.
class FlavorManager {
  final Flavor flavor;
  final String name;
  final Color color;
  final String baseUrl;
  static FlavorManager? _instance;


  static void make(Flavor flavor) {
    FlavorManager(flavor: flavor, color: flavor.color, baseUrl: flavor.url);
  }

  ///Factory Pattern
  factory FlavorManager({required Flavor flavor, required Color color, required String baseUrl}) {
    _instance ??= FlavorManager._internal(flavor, flavor.toString().substring(flavor.toString().indexOf('.') + 1), color, baseUrl);
    return _instance!;
  }


  FlavorManager._internal(this.flavor, this.name, this.color, this.baseUrl);

  static FlavorManager get instance {
    return _instance!;
  }


  //To get the base url of the backend.
  static String baseURL() => _instance!.baseUrl;

  //Here we can verify if we are in a specific flavor.
  static bool isProduction() => _instance!.flavor == Flavor.PRODUCTION;

}
