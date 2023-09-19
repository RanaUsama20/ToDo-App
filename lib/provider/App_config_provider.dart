import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier{
  String appLanguage = 'ar';
  ThemeMode appMode = ThemeMode.light;

  void ChangeLanguage(String newLanguage){
    if(appLanguage == newLanguage){
      return;
    }
    else{
      appLanguage = newLanguage;
      notifyListeners();
    }
  }
  void ChangeMode(ThemeMode newMode){
    if(appMode == newMode){
      return;
    }
    else{
      appMode = newMode;
      notifyListeners();
    }
  }
  bool isDarkMode(){
    return appMode == ThemeMode.dark;
  }


}