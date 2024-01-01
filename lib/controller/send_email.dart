// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, unrelated_type_equality_checks, unnecessary_brace_in_string_interps, unnecessary_null_comparison, avoid_function_literals_in_foreach_calls, unnecessary_string_interpolations, empty_catches, unused_element, camel_case_types

import 'dart:io';
import 'dart:typed_data';
import 'package:auth_01/widgets/Snack_Bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class Send_Email_Controller extends ChangeNotifier {
  //

  final TextEditingController create_Email_Controller = TextEditingController();
  final TextEditingController create_Message_Controller = TextEditingController();

  //  Widgets To Image ==================================================
  Uint8List? bytesController;
  File? imgFile;

  WidgetsToImageController controller_image = WidgetsToImageController();

  var attachment;
  // getImage  =================================================

  Future getImage() async {
    bytesController = bytesController;

    notifyListeners();

    String path = (await getTemporaryDirectory()).path;
    imgFile = File("$path/invoice.png");
    await imgFile!.writeAsBytes(bytesController!);
    print(imgFile!.path);

    // var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    attachment = File(imgFile!.path);
    notifyListeners();

    print('$attachment');
  }

  // Send Mail function  =================================================

  void sendMail({
    required context,
    required String create_Email,
    required String create_Message,
  }) async {
    // change your email here
    String username = 'eng.youseffawzy@gmail.com';
    String password = 'ueovkdujpjwksqhd';

    //

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Mail Service')
      ..recipients.add(create_Email)
      ..subject = 'Email-Karry'
      ..text = 'Message: $create_Message'
      ..attachments = [
        FileAttachment(attachment)
          ..location = Location.inline
          ..cid = '<myimg@3.141>'
      ];

    try {
      await send(message, smtpServer);
      Snak_Bar(context, 'Email Sent Successfully');
    } catch (e) {
      Snak_Bar(context, 'Email Not Sent ');
    }
    notifyListeners();
  }

  //======================================================================================

  // Add Company =================================================
  final fire_store = FirebaseFirestore.instance;
  TextEditingController textfield = TextEditingController();

  List<String> list_emails = [];
  String count = '';

  // Add Email ====================================================================

  add_Company(doc) {
    fire_store.collection('emails').doc('$doc').set({});
  }

  // fech Document ==========================================================

  fech_Emails() async {
    //

    for (var i in list_emails.toList()) {
      list_emails.removeRange(0, 1);
    }

    // Document ====
    QuerySnapshot snap = await FirebaseFirestore.instance.collection('emails').get();

    for (var i in snap.docs) {
      list_emails.add(i.id.toString());
    }

    notifyListeners();
  }

  //
}
