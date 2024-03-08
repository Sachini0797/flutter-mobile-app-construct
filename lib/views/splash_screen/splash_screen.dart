import 'dart:async';

import 'package:construct/views/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _SplashScreenState(){
    Timer(const Duration(milliseconds: 500), () {
      Get.off(() => const LoginScreen(),  transition: Transition.fade, curve: Curves.easeInOut, duration: const Duration(milliseconds: 2000));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: SizedBox( width: Get.width / 2,height: Get.height /2 , child: Image.asset(appLogo)),
          ),
          Image.asset(splashFooter)
        ],
      ),
    );
  }
}
