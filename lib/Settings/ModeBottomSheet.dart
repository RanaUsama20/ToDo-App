import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_rana/provider/App_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModeBottomSheet extends StatefulWidget {

  @override
  State<ModeBottomSheet> createState() => _ModeBottomSheetState();
}

class _ModeBottomSheetState extends State<ModeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: (){
                provider.ChangeMode('light') ;

              },
              child: provider.isDarkMode()?
              getUnSelectedItemWidget(AppLocalizations.of(context)!.light)
                  :
              getSelectedItemWidget(AppLocalizations.of(context)!.light)
          ),
          InkWell(
              onTap: () {
                provider.ChangeMode('dark') ;
              },
              child: provider.isDarkMode()?
              getSelectedItemWidget(AppLocalizations.of(context)!.dark)
                  :
              getUnSelectedItemWidget(AppLocalizations.of(context)!.dark)

          ),
        ],
      ),
    );

  }

  Widget getSelectedItemWidget(String text){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).primaryColor
              )),
          Icon(Icons.check,color: Theme.of(context).primaryColor,)
        ],
      ),
    );
  }

  Widget getUnSelectedItemWidget(String text){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text,
          style: Theme.of(context).textTheme.titleSmall),
    );
  }
}
