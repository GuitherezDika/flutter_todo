import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/app.dart';
import 'package:todo_app/data/presentation/screens/login/login_view_model.dart';
import 'package:todo_app/data/presentation/screens/register/register_view_model.dart';
import 'package:todo_app/data/repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('accessToken');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => RegisterViewModel(AuthRepository())),
      ChangeNotifierProvider(create: (_) => LoginViewModel(AuthRepository()))
    ],
    child: MyApp(isLoggedIn: token != null),
  ));
}