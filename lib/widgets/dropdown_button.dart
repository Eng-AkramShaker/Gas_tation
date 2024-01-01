// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/home_controller.dart';

class Custom_Dropdown extends StatefulWidget {
  const Custom_Dropdown({
    super.key,
  });

  @override
  State<Custom_Dropdown> createState() => _Custom_DropdownState();
}

class _Custom_DropdownState extends State<Custom_Dropdown> {
  var items = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
  ];

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<HomeController>(context, listen: false);

    return Container(
      height: 58,
      color: const Color.fromARGB(255, 177, 96, 170),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: DropdownButton(
          value: ctrl.count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          dropdownColor: const Color.fromARGB(255, 177, 96, 170),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
          ),
          items: items.map((int items) {
            return DropdownMenuItem(
              value: items,
              child: Text('$items'),
            );
          }).toList(),
          onChanged: (int? newValue) {
            setState(() {
              ctrl.count = newValue!;
              print(ctrl.count);
            });
          },
        ),
      ),
    );
  }
}
