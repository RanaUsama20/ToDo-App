
import 'package:flutter/material.dart';

class DialogUtils{

  static void showLoading(BuildContext context, String message){
     showDialog(
       barrierDismissible: false,
    context: context,
    builder: (context){
  return AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(),
        SizedBox(
            width: 15 ),
        Text(message)
      ],
    ),
  );
    });
  }
  static void hideLoading(BuildContext context){
    Navigator.pop(context);
  }
  static void showMessage(
      BuildContext context, String message ,
      {String? posActionName, VoidCallback? posAction,
      // String? NegActionName, VoidCallback? NegAction,
      bool isDismissible =  false, String title = 'Title'})
  {
    List<Widget> actions = [];

    if(posActionName != Null){
      actions.add(TextButton(
          onPressed: (){
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName!)));
    }

    // if(NegActionName != Null){
    //   actions.add(TextButton(
    //       onPressed: (){
    //         Navigator.pop(context);
    //         NegAction?.call();
    //       },
    //       child: Text(posActionName!)));
    // }

    showDialog(
      barrierDismissible: isDismissible,
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: actions,
            titleTextStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18
            ),
          );
        });
  }
}