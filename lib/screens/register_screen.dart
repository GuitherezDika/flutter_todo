import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  // key yang diberukan pada RegisterScreen akan diteruskan ke superclass (StatefulWidget) via super.key

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
  // annotation (catatan) di Dart artinya Mengganti
  // Dart akan memastikan kita akan benar2 mengganti method yang valid dari superclass (StatefulWidget)

  // State = tipe objek yang dibuat
  // <RegisterScreen> = widget ==> state terhubung dengan widget RegisterScreen

  // createState()
  // method yg wajib di override saat membuat StatefulWidget
  // berfungsi membuat instance dari class yg menyimpan logic dan UI => class dgn extend State<RegisterScreen

  // => _RegisterScreenState()
  // saat RegisterScreen dibangun, fungsi akan membuat dan menggunakan instance _RegisterScreenState
}

class _RegisterScreenState extends State<RegisterScreen> {
  // extends = pewarisan / turunan dari class lain
  // _RegisterScreenState = subclass (anak) dari RegisterScreen
  // dan akan mewarisi semua properti dan method-nya
  // _RegisterScreenState mengatur tampilan RegisterScreen

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // final = nilai hanya bisa ditetapkan sekali, dan tidak bisa diubah --> CONST pada JS
  // GlobalKey<FormState> = kunci unik mengakses dan control widget Form dari luar
  // bisa panggil validate(); save(), dll
  // <FormState> = Generik Type
  // akses dan kontrol state dari widget Form
  // bisa panggil fungsi FormState.validate() dengan aman
  // _formKey = nama variabel
  // _ = private dan hanya bisa diakses di dalam file ini
  // TextEditingController = class tuk kontrol input teks dari TextField atau TextFormField
  // _usernameController, _emailController, _passwordController = controller untuk setiap input field
  // mengakses teks; menghapus isi field; mendapat notifikasi bia teks berubah

  Future<void> _register() async {
    // Future = fungsi asynchronous -> fetch HTTP request
    // <void> = menyatakan fungsi tidak akan return apa pun
    // _register = nama fungsi
    // _ = private hanya bisa diakses di file ini

    if (!_formKey.currentState!.validate()) return;
    // baris ini = kalau form tidak valid -> hentikan eksekusi fungsi ini
    // currentState! = mengakses state dari Form yang terhubung dengan _formKey
    // ! objek = tidak null
    // .validate() = method dari FormState
    // memanggil semua validator di TextFormField dan akan return true (valid) dan false (not valid)
    // cek semua field yang ada validator

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://192.168.0.106:3000/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _usernameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'role': _emailController.text == 'admin@mail.com' ? 'admin' : 'user',
        }),
      );
      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data['message']}')),
        );
        Navigator.pushReplacementNamed(context, '/login');

        // tampilkan popup kecil di bawah layar dengan pesan Registrasi ...
        // ScaffoldMessanger = pengelola SnackBar ditampilkan dalam Scaffold
        // ScaffoldMessanger perlu tau di layar mana ia menampilkan snackbar
        // .of(context) = context = posisi widget saat ini (screen ini) dalam tree applikasi
        // .showSncakBar = menampilkan SnackBar ke layar

        // pushReplacementNamed = halaman saat ini diganti
        // halaman sekarang tidak masuk dalam riwayat, jadi user tidak bisa kembali
        // context = posisi widget -> navigator tau dari posisi widget mana perintah ini dikirim
        // '/login' = nama route
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error}')),
      );
    }
  } // end function FUTURE

  @override
  Widget build(BuildContext context) {
    // @override = penanda bahwa kita sedang menimpa (override) method dari superclass
    // menimpa method build() dari State<T>

    // Widget build(BuildContext context) = Method ini wajib pada StatefulWidget dan StatelessWidget
    // untuk membuat tampilan UI
    // BuildContext context = informasi posisi widget
    // context -> bisa akses theme, ukuran layar, Navigasi halaman

    return Scaffold(
        // Scaffold = widget dasar
        // build(BuildContext context) -> harus return sebuah Widget
        // Scaffold = widget -> menyediakan AppBar, Body, FloatingActionButton, Drawer, BottomNavigationBar

        appBar: AppBar(title: const Text('Register')),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) =>
                          value!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) =>
                          value!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _register, child: const Text('Daftar')),
                    const SizedBox(height: 10),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text('Sudah punya akun? Login')),
                  ],
                ))));
  } // end widget
} // end Class
