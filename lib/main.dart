import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/app.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/screens/register_screen.dart';
/*
void main() {
  // fungsi utama flutter

  // runApp(const MyApp());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: {
      '/register': (context) => const RegisterScreen(),
      '/login': (context) => const LoginScreen()
    }

    // runApp = run applikasi
    // MaterialApp = widget utama tuk menggunakan Material Design
    // --> home, routes, theme
  ));
}

 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('accessToken');

  runApp(MyApp(isLoggedIn: token != null ));
}