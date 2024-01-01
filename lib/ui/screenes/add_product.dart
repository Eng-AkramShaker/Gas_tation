// ignore_for_file: camel_case_types, unused_local_variable, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_is_empty, unused_field, use_build_context_synchronously, must_be_immutable

import 'package:auth_01/constes/ColorManager.dart';
import 'package:auth_01/controller/home_controller.dart';
import 'package:auth_01/controller/send_email.dart';
import 'package:auth_01/ui/screenes/home.dart';
import 'package:auth_01/ui/screenes/print_product.dart';
import 'package:auth_01/widgets/appBar.dart';
import 'package:auth_01/widgets/dropdown_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Add_Product extends StatefulWidget {
  const Add_Product({super.key});

  @override
  State<Add_Product> createState() => _Add_ProductState();
}

class _Add_ProductState extends State<Add_Product> {
  @override
  void initState() {
    super.initState();
    // inits();
  }

  inits() async {
    final ctrl = Provider.of<HomeController>(context, listen: false);
  }

  int refresh_item = 0;

  var items = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<HomeController>(context, listen: false);
    final email_ctrl = Provider.of<Send_Email_Controller>(context, listen: false);

    return Scaffold(
      appBar: custom_AppBar(context: context, title: 'Prodactes'),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorManager.blackColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: Text(
                    ctrl.Name_company_Screen,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),

              // name count ====================================================================
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: custom_textField(
                        ctrl: ctrl,
                        hint_text: 'Product',
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Custom_Dropdown(),
                    ),
                  ],
                ),
              ),

              // Add  ===========================================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      //

                      await ctrl.add_One_Product(ctrl.Name_company_Screen, {
                        'name': ctrl.name_product.text.toString(),
                        'count': '${ctrl.count}',
                        'edit': '0',
                      });

                      setState(() {
                        refresh_item + 1;
                      });

                      ctrl.textfield.text = '';
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: ColorManager.greenColor,
                      ),
                    ),
                  ),

                  // delete ===========================================================================

                  // ElevatedButton(
                  //   onPressed: () async {
                  //     //
                  //     // await ctrl.fire_store
                  //     //     .collection('com')
                  //     //     .doc('ali')
                  //     //     .delete();
                  //     await ctrl.get_one_company('akram');
                  //     // ----------------------------------------------
                  //     print(ctrl.One_Product);
                  //     // ============================================
                  //   },
                  //   child: const Text(
                  //     'Delete',
                  //     style: TextStyle(
                  //       color: Colors.red,
                  //     ),
                  //   ),
                  // ),

                  // Print ===========================================================================

                  ElevatedButton(
                    onPressed: () async {
                      //
                      await email_ctrl.fech_Emails();

                      int rival = 0;
                      setState(() {
                        ctrl.Total_Prodactes = [];
                      });

                      for (var i = 0; i < ctrl.One_Product.length; i++) {
                        // for

                        if (int.parse(ctrl.One_Product['$i']['count'].toString()) < int.parse(ctrl.One_Product['$i']['edit'].toString())) {
                          ctrl.Total_Prodactes.add("0");
                        } else if (int.parse(ctrl.One_Product['$i']['count'].toString()) ==
                            int.parse(ctrl.One_Product['$i']['edit'].toString())) {
                          ctrl.Total_Prodactes.add("0");
                        } else if (int.parse(ctrl.One_Product['$i']['count'].toString()) >=
                            int.parse(ctrl.One_Product['$i']['edit'].toString())) {
                          //if
                          //
                          setState(() {
                            rival = int.parse(ctrl.One_Product['$i']['count'].toString()) -
                                int.parse(ctrl.One_Product['$i']['edit'].toString());
                          });

                          ctrl.Total_Prodactes.add("$rival");
                        }
                      }
                      print('${ctrl.Total_Prodactes} \n');

                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Print_Product()));
                    },
                    child: const Text(
                      'Print',
                      style: TextStyle(
                        color: Color.fromARGB(255, 11, 73, 216),
                      ),
                    ),
                  ),

                  //
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    child: Table(
                        border: TableBorder.all(),
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                        }, // Allows to add a border decoration around your table
                        children: [
                          TableRow(children: [
                            Container(
                              color: ColorManager.primary,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                    child: Text(
                                  'prodactes',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                            Container(
                              color: ColorManager.primary,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(child: Text('Numbers', style: TextStyle(fontWeight: FontWeight.bold))),
                              ),
                            ),
                            Container(
                              color: Colors.amber,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(child: Text('Edit', style: TextStyle(fontWeight: FontWeight.bold))),
                              ),
                            ),
                          ]),
                        ]),
                  ),
                ),
              ),

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
                        return SingleChildScrollView(
                          child: SizedBox(
                            height: 450,
                            // color: ColorManager.greyColor,
                            width: double.infinity,
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              shrinkWrap: true,
                              itemCount: ctrl.One_Product.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 18),
                                  child: Card(
                                    color: ColorManager.primary,
                                    child: Table(
                                        // border: TableBorder.all(),
                                        columnWidths: {
                                          0: FlexColumnWidth(1),
                                          1: FlexColumnWidth(1),
                                          2: FlexColumnWidth(1),
                                        },
                                        children: [
                                          TableRow(children: [
                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text('${ctrl.One_Product['$i']['name']}',
                                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                              ),
                                            ),

                                            // --------------------------------------------------

                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text('${ctrl.One_Product['$i']['count']}',
                                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                              ),
                                            ), // --------------------------------------------------

                                            Card(
                                              color: Colors.amber,
                                              child: SizedBox(
                                                height: 35,
                                                child: Center(
                                                  child: DropdownButton(
                                                    value: int.parse('${ctrl.One_Product['$i']['edit']}'),
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                    dropdownColor: const Color.fromARGB(255, 177, 96, 170),
                                                    icon: const Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Colors.black,
                                                    ),
                                                    items: items.map((int items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: Text('$items', style: TextStyle(fontWeight: FontWeight.bold)),
                                                      );
                                                    }).toList(),
                                                    onChanged: (int? newValue) async {
                                                      //

                                                      await FirebaseFirestore.instance
                                                          .collection('com')
                                                          .doc(ctrl.Name_company_Screen)
                                                          .update({
                                                        "$i": {
                                                          'name': '${ctrl.One_Product['$i']['name']}',
                                                          'count': '${ctrl.One_Product['$i']['count']}',
                                                          'edit': '$newValue',
                                                        }
                                                      });

                                                      //

                                                      setState(() {
                                                        refresh_item + 1;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                        ]),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }
                  }
                },
              ),

              // =========================================================================
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> refresh_Builder() async {
    final ctrl = Provider.of<HomeController>(context, listen: false);

    await ctrl.get_one_company(ctrl.Name_company_Screen);

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
              widget.hint_text,
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

        controller: widget.ctrl.name_product,
      ),
    );
  }
}

// ===================================================================================
