import 'package:construct/views/auth_screens/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/colors.dart';
import '../../consts/images.dart';
import '../../custom_widget/app_button.dart';
import '../../custom_widget/text_field_styles.dart';
import '../home_screen/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscure = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                    child: Hero(
                        tag: "logo",
                        child: SizedBox(
                            width: 300,
                            height: 300,
                            child: Image.asset(appLogo)))),
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: textFieldStyles(
                            label: const Text("Name"),
                            hintText: "Enter your name here",
                            prefixIcon: const Icon(Icons.person)),

                        validator: (value) {
                          value!.isEmpty ? "Please enter your name" : null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFieldStyles(
                            label: const Text("email"),
                            hintText: "Enter your email here",
                            prefixIcon: const Icon(Icons.email)),
                        inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[ ]'))],

                        validator: (value) {
                          if(value == null || value.isEmpty || !value.contains('@') || !value.contains('.')){
                            return 'Invalid Email';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: TextFormField(
                        obscureText: !isObscure,
                        keyboardType: TextInputType.text,
                        decoration: textFieldStyles(
                          label: const Text("Password"),
                          hintText: "Enter your password here",
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                              icon: Icon(isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              }),
                        ),
                        validator: (value) {
                          value!.isEmpty ? "Please enter the password" : null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: TextFormField(
                        obscureText: !isObscure,
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFieldStyles(
                          label: const Text("Retype Password"),
                          hintText: "Retype password here",
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                              icon: Icon(isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              }),
                        ),
                        validator: (value) {
                          value!.isEmpty ? "Please retype the password" : null;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              appButton(
                  title: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: appColor,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        Get.off(() => LoginScreen());
                      });
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: RichText(
                    text: TextSpan(
                        text: "Have an Account?",
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: " Sign in here",
                              style: const TextStyle(color: appOrange),
                              recognizer: TapGestureRecognizer()..onTap = () {})
                        ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
