import 'package:todo_app/data/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<String> register(String email, String username, String password) async {
    try {
      return await _authService.registerUser(email, username, password);
    } catch (e) {
      throw Exception('Repository Error: $e');
    }
  }
}