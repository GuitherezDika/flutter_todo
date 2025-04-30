import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/routes/app_routes.dart';

class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({super.key});

  Future<String> _getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    return token != null ? AppRoutes.home : AppRoutes.login;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        // Fungsi Flutter untuk menjalankan proses Asynchronous => API Call, SharedPreferences, or database
        // build UI berdasar status dari Future
        // builders = fungsi membangun UI dan mendapat parameter BuildContext context dan AsyncSnapshot snapshot
        future: _getInitialRoute(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // FUngsi ini akan menunda eksekusi kode di dalamnya sampai frame saat ini selesai dibangun
            // di render di layar
            Navigator.pushReplacementNamed(context, snapshot.data!);
          });
          // menjalankan navigasi atau fungsi lain setelah frame pertama selesai di render

          return const SizedBox();
        });
  }
}
