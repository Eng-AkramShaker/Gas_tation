// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Snak_Bar(BuildContext context, SnackMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // ignore: sized_box_for_whitespace
      backgroundColor: const Color.fromARGB(255, 96, 94, 94),
      content: SizedBox(
        height: 40,
        child: Center(
            child: Text(
          SnackMessage,
          style: const TextStyle(color: Color(0xff14DAE2), fontSize: 13),
        )),
      ),
      duration: const Duration(milliseconds: 2000),
      width: 280.0, // Width of the SnackBar.
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
