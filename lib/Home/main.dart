import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_rana/Home/HomeScreen.dart';
import 'package:todo_rana/Home/MyTheme.dart';
import 'package:todo_rana/Task_list/TaskDetailsScreen.dart';
import 'package:todo_rana/provider/App_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main(){
  runApp(ChangeNotifierProvider(
    create: (context) => AppConfigProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      locale: Locale(provider.appLanguage) ,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      initialRoute: HomeScreen.routeName ,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen(),
        TaskDetailsScreen.routeName : (context) => TaskDetailsScreen(),
      },
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.appMode,
    );
  }

}