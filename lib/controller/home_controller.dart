// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, unrelated_type_equality_checks, unnecessary_brace_in_string_interps, unnecessary_null_comparison, avoid_function_literals_in_foreach_calls, unnecessary_string_interpolations, empty_catches, unused_element

import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  //
  final auth = FirebaseAuth.instance;
  final fire_store = FirebaseFirestore.instance;

  // ===================================================
  int count = 0;
  String Name_company_Screen = '';

  List list_document = [];
  final textfield = TextEditingController();

  final name_product = TextEditingController();

  SplayTreeMap One_Product = SplayTreeMap();

  List Total_Prodactes = [];

  // Add Company =================================================

  add_Company(doc) {
    fire_store.collection('com').doc('$doc').set({});
  }

  //  fech Document and allData ==========================================================

  fech_Document_and_allData() async {
    //

    for (var i in list_document.toList()) {
      list_document.removeRange(0, 1);
    }

    // Document ======================================================

    QuerySnapshot snap = await FirebaseFirestore.instance.collection('com').get();

    for (var i in snap.docs) {
      list_document.add(i.id.toString());
    }

    notifyListeners();
  }

  // Add Product =========================================================================

  add_One_Product(String doc, Map add_Map) async {
    //
    await get_one_company(doc);
    int num = One_Product.isEmpty ? 0 : One_Product.length;

    await FirebaseFirestore.instance.collection('com').doc(doc).set(
      {
        "$num": add_Map,
      },
      SetOptions(merge: true),
    );
    await get_one_company(doc);

    notifyListeners();
  }

  // get one company ====================================================================

  get_one_company(String doc) async {
    One_Product = SplayTreeMap();

    List items = [];
    var data = await FirebaseFirestore.instance.collection('com').get();

    items.addAll(data.docs);

    for (var i = 0; i < items.length; i++) {
      //

      if (items[i].id.toString() == "$doc") {
        One_Product = SplayTreeMap<String, dynamic>.from(items[i].data(), (keys1, keys2) => keys1.compareTo(keys2));
      }
    }
    print(One_Product);
  }
  //
}
