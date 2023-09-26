import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_rana/Home/MyTheme.dart';
import 'package:todo_rana/Settings/LanguageBottomSheet.dart';
import 'package:todo_rana/Settings/ModeBottomSheet.dart';
import 'package:todo_rana/provider/App_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsTab extends StatefulWidget {

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
    title: Text(AppLocalizations.of(context)!.settings,
    style: Theme.of(context).textTheme.titleLarge),
    ),
    body:
    Container(
      margin: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.titleMedium,),
          ),
          SizedBox(
            height: 15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(

                  color: MyTheme.whiteColor,
                  border: Border.all(
                      color: Theme.of(context).primaryColor
                  )
              ),
              child: InkWell(
                onTap: (){
                  showLanguageBottomSheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text( provider.appLanguage == 'en'?
                    AppLocalizations.of(context)!.english
                      :
                    AppLocalizations.of(context)!.arabic,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).primaryColor
                        )),
                    Icon(Icons.arrow_drop_down,color: Theme.of(context).primaryColor
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(AppLocalizations.of(context)!.mode,
              style: Theme.of(context).textTheme.titleMedium,),
          ),
          SizedBox(
            height: 15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: MyTheme.whiteColor,
                border: Border.all(
                  color: Theme.of(context).primaryColor
                )
              ),
              child: InkWell(
                onTap: (){
                  showModeBottomSheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(provider.appTheme() == ThemeMode.light?
                    AppLocalizations.of(context)!.light
                    :
                    AppLocalizations.of(context)!.dark,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).primaryColor
                        )),
                    Icon(Icons.arrow_drop_down, color: Theme.of(context).primaryColor
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    ),);
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(context: context,
        builder: (context) => LanguageBottomSheet());
  }

  void showModeBottomSheet() {
    showModalBottomSheet(context: context,
        builder: (context) => ModeBottomSheet());
  }



}
