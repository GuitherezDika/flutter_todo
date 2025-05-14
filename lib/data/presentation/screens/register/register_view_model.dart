import 'package:todo_app/data/repositories/auth_repository.dart';

class RegisterViewModel {
  final AuthRepository _authRepository = AuthRepository();

  Future<String> register(String email, String username, String password) async {
    try {
      return await _authRepository.register(email, username, password);
    } catch (e) {
      return 'Error: $e';
    }
  }
}