import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_rana/DialogUtils/DialogUtils.dart';
import 'package:todo_rana/Firebase_utils/Firebase_utils.dart';
import 'package:todo_rana/Home/HomeScreen.dart';
import 'package:todo_rana/model/my_user.dart';

import 'package:todo_rana/custom_text_form_field/custom_text_form_field.dart';
import 'package:todo_rana/provider/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register Screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var  nameController = TextEditingController(text: 'Rana');

  var  emailController = TextEditingController(text: 'Rana@route.com');

  var  passwordController = TextEditingController(text: '123456789');

  var  confirmPasswordController = TextEditingController(text: '123456789');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/main_background.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Form(
             key: formKey,
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                CustomTextFormField(
                  controller: nameController,
                  myValidator:(text) {
                    if(text == null || text.trim().isEmpty){
                      return 'please enter the username ';
                    }
                    return null;
                  },
                  label: 'User Name',
                ),
                CustomTextFormField(
                  controller: emailController,
                  myValidator:(text) {
                    if(text == null || text.trim().isEmpty){
                      return 'please enter Email Address ';
                    }
                    bool emailValid =
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if(!emailValid){
                      return 'please enter a valid email';
                    }
                    return null;
                  },

                  label: 'Email',
                ),
                CustomTextFormField(
                    label: 'password',
                    controller: passwordController,
                    myValidator: (text) {
                      if(text == null || text.trim().isEmpty){
                        return 'please enter a password';
                      }
                      if(text.length < 6){
                        return 'password should be at least 6 chars';
                      }
                      return null;
                    },
                isPassword: true,
                keyboardType: TextInputType.number),
                CustomTextFormField(
                    controller: confirmPasswordController,
                    myValidator:(text) {
                      if(text == null || text.trim().isEmpty){
                        return 'please enter the password ';
                      }
                      if(text != passwordController.text){
                        return "password doesn't match";
                      }
                      return null;
                    },
                    label: 'Confirm Password',
                    isPassword: true,
                    keyboardType: TextInputType.number),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: (){
                        register();
                      },
                      child: Text('Register',
                      style: Theme.of(context).textTheme.titleLarge,)),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  void register()async {
    if(formKey.currentState?.validate() == true){

      DialogUtils.showLoading(context, 'Loading....');
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid??'',
            name: nameController.text,
            email: emailController.text);
        var authProvider = Provider.of<AuthProvider>(context,listen: false);
        authProvider.updateUser(myUser);
        await Firebase_Utils.addUserToFireStore(myUser);

        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context,
            'register successfully',
            title: 'success',
            posActionName: 'Ok',
            posAction: (){
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            });

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.showMessage(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.showMessage(context, 'The account already exists for that email.');
        }
      }  catch(e){
        DialogUtils.showMessage(context, e.toString());
      }
    }
  }
}
