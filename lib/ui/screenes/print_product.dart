// ignore_for_file: camel_case_types, unused_local_variable, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_is_empty, unused_field, use_build_context_synchronously, unnecessary_string_interpolations, unnecessary_import, empty_catches, sized_box_for_whitespace

import 'dart:io';

import 'package:auth_01/constes/ColorManager.dart';
import 'package:auth_01/controller/home_controller.dart';
import 'package:auth_01/controller/send_email.dart';
import 'package:auth_01/widgets/appBar.dart';
import 'package:auth_01/widgets/dropdown_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class Print_Product extends StatefulWidget {
  const Print_Product({super.key});

  @override
  State<Print_Product> createState() => _Print_ProductState();
}

class _Print_ProductState extends State<Print_Product> {
  @override
  void initState() {
    super.initState();
    inits();
  }

  inits() async {
    final ctrl = Provider.of<HomeController>(context, listen: false);
    final email_ctrl = Provider.of<Send_Email_Controller>(context, listen: false);

    await ctrl.get_one_company(ctrl.Name_company_Screen);

    Future.delayed(const Duration(seconds: 1), () async {
      try {
        email_ctrl.bytesController = await email_ctrl.controller_image.capture();
      } catch (e) {}
    });
  }

  int refresh_item = 0;

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<HomeController>(context, listen: false);
    final email_ctrl = Provider.of<Send_Email_Controller>(context, listen: false);

    return Scaffold(
      appBar: custom_AppBar(context: context, title: 'Print'),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color.fromARGB(255, 146, 198, 214),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),

              SizedBox(
                // color: ColorManager.greyColor,
                child: FutureBuilder(
                  future: refresh_Builder(), // async work
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Column(
                          children: [
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 510,
                                  // color: ColorManager.greyColor,
                                  child: Container(
                                    height: double.infinity,
                                    width: 300,
                                    child: WidgetsToImage(
                                      controller: email_ctrl.controller_image,
                                      child: SingleChildScrollView(
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: ListView.builder(
                                            // padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                                            shrinkWrap: true,
                                            itemCount: ctrl.Total_Prodactes.length,
                                            itemBuilder: (BuildContext context, int i) {
                                              return Column(
                                                children: [
                                                  Table(border: TableBorder.all(), columnWidths: {
                                                    0: FlexColumnWidth(1),
                                                    1: FlexColumnWidth(1),
                                                    2: FlexColumnWidth(1),
                                                  }, children: [
                                                    TableRow(children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(3),
                                                        child: Center(
                                                          child: Text('Name'),
                                                        ),
                                                      ),

                                                      // --------------------------------------------------
                                                      Padding(
                                                        padding: EdgeInsets.all(3),
                                                        child: Center(
                                                          child: Text('${ctrl.One_Product['$i']['name']}'),
                                                        ),
                                                      ),

                                                      // --------------------------------------------------

                                                      Padding(
                                                        padding: const EdgeInsets.all(3),
                                                        child: Center(
                                                          child: Text('${ctrl.Total_Prodactes[i]}'),
                                                        ),
                                                      )
                                                    ]),
                                                  ]),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Add Email ====================================================================

                                Container(
                                  color: Colors.black,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                          SizedBox(
                                            height: 60,
                                            width: 300,
                                            child: custom_textField(
                                              ctrl: email_ctrl.textfield,
                                              hint_text: 'Email :',
                                            ),
                                          ),
                                          const SizedBox(width: 30),
                                          ElevatedButton(
                                            onPressed: () async {
                                              //
                                              await email_ctrl.add_Company('${email_ctrl.textfield.text}');

                                              setState(() {
                                                email_ctrl.create_Email_Controller.text = email_ctrl.textfield.text;

                                                email_ctrl.textfield.text = '';
                                              });
                                            },
                                            child: const Text(' Add '),
                                          ),
                                        ]),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Custom_DropdownButton(),
                                            const SizedBox(width: 30),
                                            ElevatedButton(
                                              onPressed: () async {
                                                email_ctrl.bytesController = await email_ctrl.controller_image.capture();
                                                email_ctrl.bytesController = await email_ctrl.controller_image.capture();

                                                await email_ctrl.getImage();

                                                email_ctrl.sendMail(
                                                  context: context,
                                                  create_Email: email_ctrl.create_Email_Controller.text.toString(),
                                                  create_Message: email_ctrl.create_Message_Controller.text.toString(),
                                                );
                                              },
                                              child: const Text('Send'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 100),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                    }
                  },
                ),
              ),

              // =========================================================================

              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       TextFormField(
              //         decoration: const InputDecoration(
              //           labelText: 'Recipient Email',
              //           border: OutlineInputBorder(
              //             borderSide: BorderSide(),
              //           ),
              //         ),
              //         controller: email_ctrl.create_Email_Controller,
              //       ),
              //       const SizedBox(height: 30),
              //       TextFormField(
              //         maxLines: 1,
              //         controller: email_ctrl.create_Message_Controller,
              //         decoration: const InputDecoration(
              //           labelText: 'Message',
              //           border: OutlineInputBorder(
              //             borderSide: BorderSide(),
              //           ),
              //         ),
              //       ),
              //       const SizedBox(height: 30),
              //       ElevatedButton(
              //         onPressed: () async {
              //           email_ctrl.bytesController = await email_ctrl.controller_image.capture();
              //           email_ctrl.bytesController = await email_ctrl.controller_image.capture();
              //           await email_ctrl.getImage();
              //           email_ctrl.sendMail(
              //             context: context,
              //             create_Email: email_ctrl.create_Email_Controller.text.toString(),
              //             create_Message: email_ctrl.create_Message_Controller.text.toString(),
              //           );
              //         },
              //         child: const Text('Send Mail'),
              //       )
              //     ],
              //   ),
              // ),

              //
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------

  Future<dynamic> refresh_Builder() async {
    final ctrl = Provider.of<HomeController>(context, listen: false);
    final email_ctrl = Provider.of<Send_Email_Controller>(context, listen: false);

    await ctrl.get_one_company(ctrl.Name_company_Screen);
    await email_ctrl.fech_Emails();

    refresh_item + 1;
  }
}

class custom_textField extends StatefulWidget {
  const custom_textField({
    super.key,
    required this.ctrl,
    required this.hint_text,
  });

  final TextEditingController ctrl;
  final String hint_text;

  @override
  State<custom_textField> createState() => _custom_textFieldState();
}

class _custom_textFieldState extends State<custom_textField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        style: (const TextStyle(fontSize: 13, color: ColorManager.blackColor, fontWeight: FontWeight.w400)),
        // obscureText: true,
        cursorColor: ColorManager.whiteColor,
        decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 177, 96, 170),
          filled: true,
          prefixIcon: Container(
            width: 70,
            padding: EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            child: Center(
              child: Text(
                widget.hint_text,
                style: TextStyle(fontSize: 13, color: ColorManager.blackColor),
              ),
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

        controller: widget.ctrl,
      ),
    );
  }
}

// =============================================================================

class Custom_DropdownButton extends StatefulWidget {
  const Custom_DropdownButton({
    super.key,
  });

  @override
  State<Custom_DropdownButton> createState() => _Custom_DropdownButtonState();
}

class _Custom_DropdownButtonState extends State<Custom_DropdownButton> {
  List<String> items = [];

  // 'Choose Email'

  @override
  void initState() {
    super.initState();

    inits();
  }

  inits() async {
    final email_ctrl = Provider.of<Send_Email_Controller>(context, listen: false);

    setState(() {
      items = email_ctrl.list_emails;

      email_ctrl.count = items.isNotEmpty ? items[0].toString() : ' ';
    });
  }

  @override
  Widget build(BuildContext context) {
    final email_ctrl = Provider.of<Send_Email_Controller>(context, listen: false);

    return Center(
      child: Container(
        height: 60,
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 177, 96, 170),
          borderRadius: BorderRadius.circular(15.0),
          // border: Border.all(color: ColorManager.blackColor, style: BorderStyle.solid, width: 0.80),
        ),
        child: DropdownButton(
          value: email_ctrl.count,
          isExpanded: true,
          borderRadius: BorderRadius.circular(30),
          style: const TextStyle(color: Colors.black, fontSize: 18),
          dropdownColor: const Color.fromARGB(255, 177, 96, 170),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          items: items.map((items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                'Chosse :  $items',
                style: TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              email_ctrl.count = newValue!;

              email_ctrl.create_Email_Controller.text = newValue;

              print('');
            });
          },
        ),
      ),
    );
  }
}
