import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  void dispose() {
    // membersihkan controller saat widget di tutup
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _registerUser(BuildContext context) async {
    /*
      BuildContext context = parameter merepresentasikan context widget fungsi dipanggil
      wajib ada apabila dalam dunction akan memanggil widget -> snackbar, navigasi, media query, tema
     */
    final viewModel = context.read<RegisterViewModel>();
    final email = _emailController.text;
    final username = _usernameController.text;
    final password = _passwordController.text;

    await viewModel.register(email, username, password);
    if (viewModel.errorMessage == null) {
      _navigateLogin();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal Registrasi')),
      );
    }
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
          child: Consumer<RegisterViewModel>(
              // Consumer = Provider Flutter dari ChangeNotifierProvider main.dart
              // peroleh instance objek dari ViewModel
              // render ulang spesifik component tertentu
              builder: (context, viewModel, child) {
                return Column(
                  children: [
                    if (viewModel.isLoading) const CircularProgressIndicator(),
                    CustomInputField(label: 'Email', controller: _emailController),
                    CustomInputField(
                        label: 'Username', controller: _usernameController),
                    CustomInputField(
                        label: 'Password',
                        controller: _passwordController,
                        obscureText: true),
                    CustomButton(
                        text: 'Daftar', onPressed: () => _registerUser(context)),
                    CustomTextButton(
                        label: 'Kembali ke Login', onPressed: _navigateLogin)
                  ],
                );
          })),
    );
  }
}

/*
MVVM
View = menampilkan data dan kelola interaksi pengguna UI (RegisterScreen)
ViewModel = jembatani model ke view; handle logika registrasi (RegisterViewModel)
        handle loading, handle Error Message
Model = Kelola data dan logika bisnis hit API (repository / AuthRepository )
 */
