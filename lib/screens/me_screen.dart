import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/routes/app_routes.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:http/http.dart' as http;

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  void _logout(BuildContext context) async {
    final url = Uri.parse('http://192.168.73.5:3000/auth/logout');

    final prefs = await SharedPreferences.getInstance();
    var refreshToken = prefs.getString('refreshToken');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'refreshToken': refreshToken,
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        debugPrint('data = ${data}');
        await prefs.remove('accessToken');
        await prefs.remove('refreshToken');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
            (Route<dynamic> route) => false);
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () => _logout(context), child: const Text('Logout')),
    );
  }
}
