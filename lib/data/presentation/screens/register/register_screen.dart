import 'package:flutter/material.dart';
import 'package:todo_app/data/presentation/screens/register/register_view_model.dart';
import 'package:todo_app/data/presentation/widgets/custom_button.dart';
import 'package:todo_app/data/presentation/widgets/custom_input_field.dart';
import 'package:todo_app/data/presentation/widgets/custom_text_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RegisterViewModel _viewModel = RegisterViewModel();
  
  @override
  void dispose() {
    // membersihkan controller saat widget di tutup
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _registerUser(BuildContext context) async {
    final email = _emailController.text;
    final username = _usernameController.text;
    final password = _passwordController.text;

    final result = await _viewModel.register(email, username, password);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${result}')),
    );
  }

  void _navigateLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomInputField(label: 'Email', controller: _emailController),
            CustomInputField(label: 'Username', controller: _usernameController),
            CustomInputField(
                label: 'Password',
                controller: _passwordController,
                obscureText: true),
            CustomButton(text: 'Daftar', onPressed: () => _registerUser(context)),
            CustomTextButton(
                label: 'Kembali ke Login', onPressed: _navigateLogin)
          ],
        ),
      ),
    );
  }
}
