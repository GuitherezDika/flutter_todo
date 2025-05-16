import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/presentation/screens/login/login_view_model.dart';
import 'package:todo_app/data/presentation/widgets/custom_button.dart';
import 'package:todo_app/data/presentation/widgets/custom_input_field.dart';
import 'package:todo_app/data/presentation/widgets/custom_text_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // clearing funct
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginUser(BuildContext context) async {
    final viewModel = context.read<LoginViewModel>();
    final username = _usernameController.text;
    final password = _passwordController.text;

    await viewModel.login(username, password);
    if (viewModel.errorMessage == null) {
      print('Login Sukses =  ${viewModel.data}');
      // fungsi navigasi
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal Login')),
      );
    }
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
          child: Consumer<LoginViewModel>(
            builder: (context, viewModel, child) {
              return Column(children: [
                if (viewModel.isLoading) const CircularProgressIndicator(),
                CustomInputField(
                    label: 'Username', controller: _usernameController),
                CustomInputField(
                    label: 'Password',
                    controller: _passwordController,
                    obscureText: true),
                CustomButton(
                    text: 'Login', onPressed: () => _loginUser(context)),
                CustomTextButton(
                    label: 'Belum punya akun? Daftar',
                    onPressed: _navigateRegister)
              ]);
            },
          )
          ),
    );
  }
}