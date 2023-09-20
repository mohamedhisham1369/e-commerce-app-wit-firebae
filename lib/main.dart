import 'package:bloc/bloc.dart';
import 'package:ecommerce/screens/cart/cartscreen.dart';
import 'package:ecommerce/screens/homescreen/homescreen.dart';
import 'package:ecommerce/screens/login/loginscreen.dart';
import 'package:ecommerce/screens/myorder/myorders.dart';
import 'package:ecommerce/screens/payment%20method/payment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constats/blocobsevalble.dart';
import 'constats/cachehelper.dart';

Future <void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  final FirebaseOptions firebaseOptions = FirebaseOptions(
    appId: '1:437854269446:android:8d0282be505689985f9387',
    apiKey: 'AIzaSyBk35aNpsh-ilFFvBsxPkL3zmTrleXVIg0',
    messagingSenderId: '437854269446',
    projectId: 'newcouresfirebase',
    // Add other configuration options as needed.
  );
  try {
    await Firebase.initializeApp(options: firebaseOptions);
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  await cachehelper.init();
  var uid = cachehelper.getdata(key: "uid");

  print(uid);

  Widget screen;

  if (uid!=null) {
    screen=homescreen();
  }

  else{
    screen=Logincsreen();

  }


  runApp( MyApp(screen: screen,));
}

class MyApp extends StatelessWidget {
  Widget? screen;



   MyApp({required this.screen});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme:AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.blue,

        ) ,


        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        primarySwatch: Colors.blue,

      ),
      
      home:screen,

    );

  }
}

