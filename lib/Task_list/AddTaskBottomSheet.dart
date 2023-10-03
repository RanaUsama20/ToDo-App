import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_rana/DialogUtils/DialogUtils.dart';
import 'package:todo_rana/Firebase_utils/Firebase_utils.dart';
import 'package:todo_rana/Home/MyTheme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_rana/provider/auth_provider.dart';
import 'package:todo_rana/provider/listProvider.dart';

import '../model/Task.dart';



class AddTaskBottomSheet extends StatefulWidget {

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late ListProvider listProvider;



  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
     return Container(
       padding: EdgeInsets.all(12),
       child: Column(
         children: [
          Text(AppLocalizations.of(context)!.add_new_task,
          style: Theme.of(context).textTheme.titleMedium,),
           Form(
             key: formKey,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: TextFormField(
                       onChanged: (text) {
                         title =  text;
                       },
                       validator: (text) {
                         if (text == null || text.isEmpty){
                           return 'please Enter a title';
                         }
                        return null;
                       },
                       decoration: InputDecoration(
                         hintText: 'Enter Task Title'
                       ),

           ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: TextFormField(
                       onChanged: (text) {
                         description =  text;
                       },
                       validator: (text) {
                         if (text == null || text.isEmpty){
                           return 'please Enter a Description';
                         }
                         return null;
                       },
                       decoration: InputDecoration(
                           hintText: 'Enter Task Description',
                       ),
                       maxLines: 4,

                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text(AppLocalizations.of(context)!.select_time,
                     style: Theme.of(context).textTheme.titleSmall,),
                   ),
                   InkWell(
                     onTap: () {

                       showCalender();

                     },
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text('${formatDate(selectedDate)}',
                         textAlign: TextAlign.center,
                         style: Theme.of(context).textTheme.titleSmall,),
                     ),
                   ),
                   ElevatedButton(onPressed: (){
                     AddTask();
                   },
                       child: Text(AppLocalizations.of(context)!.add,
                       style: Theme.of(context).textTheme.titleMedium,))



                 ],
               ))
         ],
       ),
     );
  }

  void showCalender() async{
   var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
   if (chosenDate != null ){
     selectedDate = chosenDate;

     setState(() {

     });

   }

  }
  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  void AddTask()async {
    Task task = Task(
        title: title,
        description: description,
        dateTime: selectedDate);
    if (formKey.currentState?.validate() == true){
      var authProvider = Provider.of<AuthProvider>(context,listen: false);
      DialogUtils.showLoading(context, 'Loading....');
     await Firebase_Utils.addTaskToFireBase(task,authProvider.currentUser!.id!).
     then((value) {
       DialogUtils.hideLoading(context);
       DialogUtils.showMessage(context, 'Todo added successfully',posActionName: 'ok',
       isDismissible: true);

     })
      .timeout(
          Duration(
              milliseconds: 500),
          onTimeout:(){
      print('Task is added sucessfully');
      listProvider.getAllTasksFromFirestore(authProvider.currentUser!.id!);
      Navigator.pop(context);
          }
      );

    }
  }
}


