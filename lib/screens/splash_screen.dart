import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/constant/colors.dart';
import 'package:news_app/login/sign_in.dart';
import 'package:news_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _getData() async {
    Get.offAll(()=> const SignIn());
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = const Duration(seconds: 5);
    return Timer(_duration, _getData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:backgroundColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Lottie.asset("assets/lotties/7984-breaking-news-broadcast-animation.json"),
      ),
    );
  }
}
