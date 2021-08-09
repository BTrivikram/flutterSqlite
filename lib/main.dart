import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login/login_page.dart';
import 'pages/login/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/profile_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  final routes = {
    '/login': (BuildContext context) => LoginPage(),
    '/home': (BuildContext context) => HomePage(),
    '/register': (BuildContext context) => RegisterPage(),
    '/': (BuildContext context) => LoginPage(),
    '/profilePage': (BuildContext context) => ProfilePage(),
  };
  runApp(
    MaterialApp(
      initialRoute: email == null ? '/login' : '/home',
      title: 'Sqflite App',
      theme: ThemeData.dark(),
      routes: routes,
    ),
  );
}
