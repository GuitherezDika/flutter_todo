lib/
│
├── main.dart
├── app.dart
├── routes/
│   └── app_routes.dart
├── screens/
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── resume_screen.dart
│   ├── me_screen.dart
├── widgets/
├── services/
│   └── api_service.dart
├── models/
├── providers/
│   └── auth_provider.dart

===============
lib/
│
├── main.dart               # Entry point aplikasi
├── app.dart                # Inisialisasi aplikasi
├── core/                   # Berisi logika umum dan utilitas
│   ├── config/             # Konfigurasi umum
│   ├── utils/              # Fungsi helper dan utilitas
│   └── constants/          # Konstanta global
├── data/                   # Layer data (akses API, model data, dll.)
│   ├── models/             # Model data
│   ├── services/           # Akses API dan data eksternal
│   └── repositories/       # Repositori untuk mengelola data
├── domain/                 # Layer domain (logika bisnis)
│   └── usecases/           # Logika dan aturan bisnis
├── presentation/           # Layer UI (tampilan)
│   ├── screens/            # Halaman aplikasi
│   │   ├── login/          # Fitur Login
│   │   │   ├── login_screen.dart
│   │   │   └── login_view_model.dart
|   |   ├── register/       # Fitur Register
│   │   │   ├── register_screen.dart
│   │   │   └── register_view_model.dart
│   │   ├── home/           # Fitur Home
│   │   └── resume/         # Fitur Resume
│   │       └── me/         # Fitur Me
│   ├── routes/             # Routing aplikasi
│   └── widgets/ 
        ├── custom_button.dart
        │── custom_input_field.dart
└── providers/              # State management (misalnya menggunakan Provider)
    └── auth_provider.dart

MVVM
SOLID Principles = 
  Single Responsibility Principle (SRP)
    screen hanya bertanggung jawab menampilkan UI tidak untuk proses API
  Dependency Inversion Principle (DIP):
   Komponen Lebih Tinggi (UI) tidak bergantung pada komponen lebih rendah, tapi abstraksi dari repository

MVVM Architecture
  Model: Struktur Data
  ViewModel: Mengelola data dan Logika bisnis
  View: menampilkan data di layar
  Repository: kelola data API atau lokal


/*
MVVM
View = menampilkan data dan kelola interaksi pengguna UI (RegisterScreen)
ViewModel = jembatani model ke view; handle logika registrasi (RegisterViewModel)
        handle loading, handle Error Message
Model = Kelola data dan logika bisnis hit API (repository / AuthRepository )
 */


=================

FLOW REFRESH TOKEN
[Login] 
   ↓ 
Simpan accessToken + refreshToken
   ↓ 
[Gunakan accessToken untuk semua request]
   ↓ 
[accessToken expired?]
   ↓ 
Panggil /refresh-token pakai refreshToken
   ↓ 
Dapat accessToken baru → simpan → ulangi request sebelumnya

===============
ApiService.dart

// services/api_service.dart
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ApiService {
  static const baseUrl = 'https://your-api-url.com';

  Future<http.Response> get(String endpoint) async {
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);

    if (response.statusCode == 401) {
      // Token expired
      final refreshed = await _refreshToken();
      if (refreshed) {
        final newHeaders = await _getHeaders();
        return http.get(Uri.parse('$baseUrl$endpoint'), headers: newHeaders);
      }
    }

    return response;
  }

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? '';
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<bool> _refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');
    if (refreshToken == null) return false;

    final response = await http.post(
      Uri.parse('$baseUrl/refresh-token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['accessToken'] != null) {
        await prefs.setString('accessToken', data['accessToken']);
        return true;
      }
    } else {
      await prefs.remove('accessToken');
      await prefs.remove('refreshToken');
    }

    return false;
  }
}

===========================
contoh misal pemanggilan api/me

final api = ApiService();
final response = await api.get('/me');

if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  print(data);
} else {
  print('Gagal ambil data');
}
====================