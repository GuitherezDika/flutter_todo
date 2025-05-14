import 'package:flutter/material.dart';
import 'package:todo_app/data/presentation/widgets/custom_button.dart';
import 'package:todo_app/data/presentation/widgets/custom_input_field.dart';
import 'package:todo_app/data/presentation/widgets/custom_text_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() { // buang
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
    // membersihkan sumber daya ketika tidak lagi diperlukan
  }

  void _login() {
    print("Username: ${usernameController.text}");
    print("Password: ${passwordController.text}");
  }

  void _navigateRegister() {
    Navigator.pushReplacementNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomInputField(label: 'Username', controller: usernameController),
            CustomInputField(label: 'Password', controller: passwordController),
            CustomButton(text: 'Login', onPressed: _login),
            CustomTextButton(label: 'Belum punya akun? Daftar', onPressed: _navigateRegister)
          ],
        ),
      ),
    );
  }
}