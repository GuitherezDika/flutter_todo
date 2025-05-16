import 'package:todo_app/data/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  // Metode Register
  Future<String> register(String email, String username, String password) async {
    try {
      return await _authService.registerUser(email, username, password);
    } catch (e) {
      throw Exception('Registration Repository Error: $e');
    }
  }

  // Methode Login
  Future<String> login(String username, String password) async {
    try {
      return await _authService.loginUser(username, password);
    } catch (e) {
      throw Exception('Login Repository Error: $e');
    }
  }
}