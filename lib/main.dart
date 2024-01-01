import 'package:auth_01/controller/home_controller.dart';
import 'package:auth_01/controller/send_email.dart';
import 'package:auth_01/ui/screenes/home.dart';
import 'package:auth_01/ui/splash_screen/splash%20_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: _providers, child: const MyApp()));
}

final dynamic _providers = [
  //
  ChangeNotifierProvider(create: (ctx) => HomeController()),
  ChangeNotifierProvider(create: (ctx) => Send_Email_Controller()),
];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => HomeController(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MaterialApp(
            title: 'Flutter karry',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Poppins',
            ),
            debugShowCheckedModeBanner: false,
            home: const Splash_Screen(),
            // home: const Home(),
          ),
        ));
  }
}


// aaa@gmail.com
