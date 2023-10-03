import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_rana/Firebase_utils/Firebase_utils.dart';
import 'package:todo_rana/custom_text_form_field/custom_text_form_field.dart';
import 'package:todo_rana/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login Screen';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        print('login successfully');
        print(credential.user?.uid ??'');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      } catch(e){
        print('error ${e.toString()}');
      }
    }
  }
}
