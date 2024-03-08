import 'package:construct/consts/colors.dart';
import 'package:construct/custom_widget/app_button.dart';
import 'package:construct/views/auth_screens/signup_screen.dart';
import 'package:construct/views/dashboard/dashboard.dart';
import 'package:construct/views/home_screen/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../consts/images.dart';
import '../../custom_widget/text_field_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    "Login",
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
                        keyboardType: TextInputType.emailAddress,
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
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              appButton(
                  title: const Text(
                    "Log in",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: appColor,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        Get.off(() => HomeScreen());
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
                        text: "No Account?",
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                      TextSpan(
                          text: " Sign up here",
                          style: const TextStyle(color: appOrange),
                          recognizer: TapGestureRecognizer()..onTap = () {})
                    ])),
              ),
              const SizedBox(
                height: 10,
              ),
              appButton(
                  title: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: appOrange,
                  onPress: () {
                    Get.off(() => SignUpScreen());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

