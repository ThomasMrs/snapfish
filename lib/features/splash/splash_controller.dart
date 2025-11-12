import 'dart:async';
import 'package:flutter/material.dart';

class SplashController {
  static void startTimer(BuildContext context, Widget destination) {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => destination),
      );
    });
  }
}
