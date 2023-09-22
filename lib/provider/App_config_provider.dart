import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier{
   SharedPreferences? preference;
  String get appLanguage => preference?.getString('language') ?? 'ar';
  String get appMode => preference?.getString('mode') ?? 'light';

  AppConfigProvider() {
    loadPrefs();
  }

  void loadPrefs()async{
    preference = await SharedPreferences.getInstance();
    notifyListeners();
  }

  ThemeMode? appTheme(){
    if(appMode == 'light' || appMode == 'مضئ' ){
      return ThemeMode.light;
    }
    else if(appMode == 'dark' || appMode == 'داكن'){
      return ThemeMode.dark;
    }
    notifyListeners();
  }

  Future <void> ChangeLanguage(String newLanguage)async{
    if(appLanguage == newLanguage){
      return;
    }
    else{
      await preference?.setString('language', newLanguage);
      notifyListeners();
    }
  }
  Future <void> ChangeMode(String newMode)async{
    if(appMode == newMode){
      return;
    }
    else{
    await preference?.setString('mode', newMode);
    notifyListeners();
    }
  }
  bool isDarkMode(){
    return appMode == ThemeMode.dark;
  }


}