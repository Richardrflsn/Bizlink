import 'dart:async';

import 'package:bizlink/providers/auth.gate.dart';
import 'package:bizlink/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Get.to(() =>
          const AuthGate(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 400),
      );
    });
    return Scaffold(
      backgroundColor: GlobalColors.neutralColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/iconBizlink.png',
              width: 250,
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            const Text(
              'Bizlink',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
