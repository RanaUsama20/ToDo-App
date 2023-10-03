import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_rana/DialogUtils/DialogUtils.dart';
import 'package:todo_rana/Firebase_utils/Firebase_utils.dart';
import 'package:todo_rana/Home/HomeScreen.dart';
import 'package:todo_rana/custom_text_form_field/custom_text_form_field.dart';
import 'package:todo_rana/register/register_screen.dart';

import '../provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: 'Rana@route.com');

  var passwordController = TextEditingController(text: '123456789');

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
                        controller: passwordController,
                        myValidator:(text) {
                          if(text == null || text.trim().isEmpty){
                            return 'please enter a password ';
                          }
                          if(text.length < 6 ){
                            return 'password should be at least 6 chars';
                          }
                          return null;
                        },

                        label: 'Password',
                        isPassword: true,
                        keyboardType: TextInputType.number),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: (){
                            login();
                          },
                          child: Text('Login',
                            style: Theme.of(context).textTheme.titleLarge,)),
                    ),
                    SizedBox(
                      height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?", style: Theme.of(context).textTheme.titleMedium,),
                        TextButton(
                            onPressed: (){
                              Navigator.of(context).pushNamed(RegisterScreen.routeName);
                            },
                            child: Text('Sign Up', style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).primaryColor
                            )
                            )
                        )
                      ],
                    )

                  ],
                ),
              ))
        ],
      ),
    );
  }

  void login()async {
    if(formKey.currentState?.validate() == true) {

      DialogUtils.showLoading(context, 'Loading....');

      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
       var user = await Firebase_Utils.readUserFromFireStore(credential.user?.uid??'');

        if(user == null){
         return;
       }
        var authProvider = Provider.of<AuthProvider>(context,listen: false);
        authProvider.updateUser(user);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context,
            'Login successfully',
            title: 'success',
            posActionName: 'Ok',
            posAction: (){
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            });

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.showMessage(context, 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          DialogUtils.showMessage(context, 'Wrong password provided for that user.');

        }
      } catch(e){
        DialogUtils.showMessage(context, e.toString());

      }
    }
  }
}
