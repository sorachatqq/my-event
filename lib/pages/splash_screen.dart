import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../utils/state/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthState authController = Get.put(AuthState());

  @override
  void initState() {
    init();

    super.initState();
  }

  init() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Timer.run(() {
      // ignore: unnecessary_null_comparison
      if (authController.isAuthenticated()) {
        context.go(context.namedLocation('home'));
      } else {
        context.go(context.namedLocation('login'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   'Splash Screen',
            // ),
          ],
        ),
      ),
    );
  }
}
