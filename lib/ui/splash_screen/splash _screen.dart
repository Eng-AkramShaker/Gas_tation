// ignore_for_file: unnecessary_import, unused_import, library_private_types_in_public_api, use_full_hex_values_for_flutter_colors, avoid_print, use_build_context_synchronously, unused_local_variable, camel_case_types

import 'dart:async';
import 'dart:math';

import 'package:auth_01/widgets/Snack_Bar.dart';
import 'package:auth_01/widgets/rounded_btn.dart';
import 'package:auth_01/ui/auth/register.dart';
import 'package:auth_01/ui/auth/login.dart';
import 'package:auth_01/ui/success/success.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  _Splash_ScreenState createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 130, bottom: 40),
                child: Text(
                  'Welcome',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 40),
                ),
              ),
              Image.asset(
                'images/logo.png',
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
