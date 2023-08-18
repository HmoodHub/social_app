// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';



enum KeysPref{
  IDUSER
}
class SharedPref{
  // THIS IS SINGLETON CLASS
  SharedPref._();
  static final SharedPref _instance =SharedPref._();
  late SharedPreferences sharedPreferences;
  factory SharedPref(){
    return _instance;
  }
  Future<void> initPref()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }


  Future<bool> setUserId(String? id)async{
    return sharedPreferences.setString(KeysPref.IDUSER.toString(), id??'');
  }

  String? get userId {
    return sharedPreferences.getString(KeysPref.IDUSER.toString());
  }
}