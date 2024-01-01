// ignore_for_file: non_constant_identifier_names

import 'package:auth_01/constes/ColorManager.dart';
import 'package:auth_01/ui/auth/login.dart';
import 'package:flutter/material.dart';

AppBar custom_AppBar({required context, required String title}) {
  return AppBar(
    backgroundColor: ColorManager.darkColor,
    centerTitle: true,
    leadingWidth: 20,
    automaticallyImplyLeading: false,
    actions: [
      IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_forward,
          color: ColorManager.primary,
          size: 30,
        ),
      ),
    ],
    leading: IconButton(
      padding: const EdgeInsets.only(left: 8),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Login(),
            ),
            (Route<dynamic> route) => false);
      },
      icon: const Icon(
        Icons.logout_rounded,
        color: Colors.red,
        size: 30,
      ),
    ),
    title: Text(
      title ?? '',
      style: const TextStyle(
        color: ColorManager.primary,
        fontSize: 23,
        fontWeight: FontWeight.w700,
        fontFamily: 'Tajawal',
      ),
    ),
  );
}
