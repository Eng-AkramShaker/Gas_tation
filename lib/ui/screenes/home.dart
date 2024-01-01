// ignore_for_file: unnecessary_import, unused_import, library_private_types_in_public_api, use_full_hex_values_for_flutter_colors, avoid_print, use_build_context_synchronously, unused_local_variable, non_constant_identifier_names, prefer_const_constructors, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, camel_case_types, must_be_immutable

import 'dart:collection';
import 'dart:ffi';

import 'package:auth_01/constes/ColorManager.dart';
import 'package:auth_01/controller/send_email.dart';
import 'package:auth_01/ui/screenes/add_product.dart';
import 'package:auth_01/ui/screenes/const_prodactes.dart';
import 'package:auth_01/ui/screenes/print_product.dart';
import 'package:auth_01/widgets/Snack_Bar.dart';
import 'package:auth_01/widgets/appBar.dart';
import 'package:auth_01/widgets/dropdown_button.dart';
import 'package:auth_01/widgets/rounded_btn.dart';
import 'package:auth_01/controller/home_controller.dart';
import 'package:auth_01/ui/auth/register.dart';
import 'package:auth_01/ui/success/success.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //

  int refresh_item = 0;

  @override
  void initState() {
    super.initState();
  }

  inits() async {
    final ctrl = Provider.of<HomeController>(context, listen: false);

    final email_ctrl = Provider.of<Send_Email_Controller>(context, listen: false);
    await email_ctrl.fech_Emails();
  }

  // --------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<HomeController>(context, listen: false);

    return Scaffold(
      appBar: custom_AppBar(context: context, title: 'Companies'),
      resizeToAvoidBottomInset: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorManager.blackColor,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          child: custom_textField(
                            ctrl: ctrl,
                            hint_text: 'Name',
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Add Company ===========================================================================

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          //
                          await ctrl.add_Company(ctrl.textfield.text);

                          // =================================================

                          ctrl.textfield.text = '';

                          setState(() {
                            refresh_item + 1;
                          });
                        },
                        child: const Text(
                          'Add Company',
                          style: TextStyle(
                            color: ColorManager.greenColor,
                          ),
                        ),
                      ),

                      // // delete ===========================================================================

                      // ElevatedButton(
                      //   onPressed: () async {
                      //     //

                      //     await ctrl.fech_Document_and_allData();

                      //     // ----------------------------------------------

                      //     setState(() {
                      //       refresh_item + 1;
                      //     });
                      //   },
                      //   child: const Text(
                      //     'Delete Company',
                      //     style: TextStyle(
                      //       color: Colors.red,
                      //     ),
                      //   ),
                      // ),

                      // // ====================================================

                      //
                    ],
                  ),
                  // ------------------------------------

                  // ListView ===========================================================================

                  FutureBuilder(
                    future: refresh_Builder(), // async work
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return SizedBox(
                              height: 400,
                              // color: ColorManager.greenColor,
                              width: double.infinity,
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                                shrinkWrap: true,
                                itemCount: ctrl.list_document.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return Card(
                                    child: custom_Slide(
                                      title: '${ctrl.list_document[i]}',
                                      name_index: '${ctrl.list_document[i]}',
                                      onTap: () async {
                                        //

                                        setState(() {
                                          ctrl.Name_company_Screen = ctrl.list_document[i].toString();
                                        });

                                        await ctrl.get_one_company(ctrl.Name_company_Screen);

                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Const_Prodactes()));
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future refresh_Builder() async {
    final ctrl = Provider.of<HomeController>(context, listen: false);

    await ctrl.fech_Document_and_allData();
    refresh_item + 1;
  }
}

class custom_textField extends StatefulWidget {
  const custom_textField({
    super.key,
    required this.ctrl,
    required this.hint_text,
  });

  final HomeController ctrl;
  final String hint_text;

  @override
  State<custom_textField> createState() => _custom_textFieldState();
}

class _custom_textFieldState extends State<custom_textField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        style: (const TextStyle(color: ColorManager.whiteColor, fontWeight: FontWeight.w400)),
        // obscureText: true,
        cursorColor: ColorManager.whiteColor,
        decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 177, 96, 170),
          filled: true,
          prefixIcon: Container(
            width: 70,
            padding: EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              '${widget.hint_text}',
              style: TextStyle(color: ColorManager.blackColor),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),

        controller: widget.ctrl.textfield,
      ),
    );
  }
}

class custom_Slide extends StatelessWidget {
  custom_Slide({
    super.key,
    required this.title,
    required this.name_index,
    required this.onTap,
  });
  String title;
  String name_index;
  Function() onTap;
  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<HomeController>(context, listen: false);

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Slidable(
            key: ValueKey(1),
            startActionPane: ActionPane(
              extentRatio: 0.5,
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  flex: 1,
                  onPressed: (v) {
                    //
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                // SlidableAction(
                //   flex: 1,
                //   onPressed: (v) {
                //     //

                //     ctrl.Name_company_Screen = name_index.toString();

                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const Print_Product()));
                //   },
                //   backgroundColor: Color(0xFF21B7CA),
                //   foregroundColor: Colors.white,
                //   icon: Icons.edit,
                //   label: 'Edit',
                // ),
                SlidableAction(
                  flex: 1,
                  onPressed: (v) {
                    //

                    ctrl.Name_company_Screen = name_index.toString();

                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Add_Product()));
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.add,
                  label: 'Add',
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: ListTile(title: Text('$title')),
            ),
          ),
        ],
      ),
    );
  }
}
