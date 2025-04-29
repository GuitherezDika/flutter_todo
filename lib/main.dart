import 'package:flutter/material.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/screens/register_screen.dart';

void main() {
  // fungsi utama flutter

  // runApp(const MyApp());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/register',
    routes: {
      '/register': (context) => const RegisterScreen(),
      '/login': (context) => const LoginScreen()
    }

    // runApp = run applikasi
    // MaterialApp = widget utama tuk menggunakan Material Design
    // --> home, routes, theme
  ));
}

