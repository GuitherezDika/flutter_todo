import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/routes/app_routes.dart';
import 'package:todo_app/screens/login_screen.dart';

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ), 
      (Route<dynamic> route) => false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () => _logout(context), child: const Text('Logout')),
    );
  }
}
