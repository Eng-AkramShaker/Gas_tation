// ignore_for_file: camel_case_types, unused_local_variable, prefer_const_constructors

import 'package:auth_01/constes/ColorManager.dart';
import 'package:auth_01/controller/home_controller.dart';
import 'package:auth_01/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Const_Prodactes extends StatefulWidget {
  const Const_Prodactes({super.key});

  @override
  State<Const_Prodactes> createState() => _Const_ProdactesState();
}

class _Const_ProdactesState extends State<Const_Prodactes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<HomeController>(context, listen: false);

    return Scaffold(
      appBar: custom_AppBar(context: context, title: 'Prodactes'),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorManager.greyColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  child: Text(
                    ctrl.Name_company_Screen,
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 500,
                padding: const EdgeInsets.only(right: 30, left: 30),
                color: ColorManager.greenColor,
                width: double.infinity,
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int i) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text('data'),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
