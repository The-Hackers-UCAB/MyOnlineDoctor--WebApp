import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageProvider {


  static saveData(String key, String value) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);

  }


  static readData(String key) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey(key)){
      return prefs.getString(key);
    }

    return '';

  }


  static removeData(String key) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(key);

  }


}