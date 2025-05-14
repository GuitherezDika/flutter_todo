

import 'package:flutter/material.dart';
import 'package:todo_app/data/presentation/screens/login/login_screen.dart';
import 'package:todo_app/data/presentation/screens/register/register_screen.dart';
import 'package:todo_app/routes/app_routes.dart';
import 'package:todo_app/screens/auth_check_screen.dart';
import 'package:todo_app/screens/home_screen.dart';
// import 'package:todo_app/screens/login_screen.dart';
// import 'package:todo_app/screens/register_screen.dart';

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  
  const MyApp({ super.key, required this.isLoggedIn });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthCheckScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
      },
    );
  }
}