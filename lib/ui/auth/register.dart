// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, unnecessary_import, unused_local_variable, unnecessary_null_comparison

import 'package:auth_01/widgets/rounded_btn.dart';
import 'package:auth_01/controller/home_controller.dart';
import 'package:auth_01/ui/auth/login.dart';
import 'package:auth_01/ui/success/success.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool showSpinner = false;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<HomeController>(context, listen: false);

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          leading: _goBackButton(context),
          backgroundColor: const Color(0xff251F34),
        ),
        backgroundColor: const Color(0xff251F34),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Please fill the input below.',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'E-mail',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: (const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400)),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: const Color(0xfff3b324e),
                        filled: true,
                        prefixIcon: Image.asset('images/icon_email.png'),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff14DAE2), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Password',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: (const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400)),
                      obscureText: true,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: const Color(0xfff3b324e),
                        filled: true,
                        prefixIcon: Image.asset('images/icon_lock.png'),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff14DAE2), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: RoundedButton(
                    btnText: 'SIGN UP',
                    color: const Color(0xff14DAE2),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        await ctrl.auth.createUserWithEmailAndPassword(
                            email: email!, password: password!);

                        // if (result != null) {
                        //   FirebaseFirestore.instance
                        //       .collection('users')
                        //       .doc()
                        //       .set(
                        //     {'email': email, 'password': password},
                        //   );
                        // }

                        // ----------------------------------
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SuccessScreen()));

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                      // Add login code
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.w400),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: const Text('Sign in',
                        style: TextStyle(
                          color: Color(0xff14DAE2),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _goBackButton(BuildContext context) {
  return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.grey[350]),
      onPressed: () {
        Navigator.of(context).pop(true);
      });
}
