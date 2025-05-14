import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/core/config/api_config.dart';

class AuthService {
  Future<String> registerUser(
      String email, String username, String password) async {
    // FUture untuk call HTTP dan asynchronous
    try {
      final url = Uri.parse(ApiConfig.register);
      final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'username': username,
            'email': email,
            'password': password,
            'role': email == 'admin@mail.com' ? 'admin' : 'user'
          }));

      if (response.statusCode == 201) {
        return 'Success';
      } else {
        return 'Failed to register: $response';
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }
}
