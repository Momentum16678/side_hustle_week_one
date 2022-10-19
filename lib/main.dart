import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:side_hustle_week_one/home_screen.dart';
import 'package:side_hustle_week_one/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initializing the firebase app
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}