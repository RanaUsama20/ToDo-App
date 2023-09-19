import 'package:flutter/material.dart';
import 'package:todo_rana/Home/MyTheme.dart';
import 'package:intl/intl.dart';


class AddTaskBottomSheet extends StatefulWidget {

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
     return Container(
       padding: EdgeInsets.all(12),
       child: Column(
         children: [
          Text('Add New Task',
          style: Theme.of(context).textTheme.titleMedium,),
           Form(
             key: formKey,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: TextFormField(
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
                     child: Text('Select Time',
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
                       child: Text('Add',
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
        initialDate: DateTime.now(),
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

  void AddTask() {
    if (formKey.currentState?.validate() == true){

    }
  }
}


