import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  LoginViewModel(this._authRepository);

  bool _isLoading = false;
  String? _errorMessage;
  Object? _data;

  bool get isLoading => _isLoading; // as provider to other screen - main.dart
  String? get errorMessage =>
      _errorMessage; // as provider to other screen - main.dart
  Object? get data => _data; // as provider to other screen - main.dart

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _setData(Object? result) {
    _data = result;
    notifyListeners();
  }

  // simpan local storage
  Future<void> _saveToLocalStorage(String token, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
    await prefs.setString('refreshToken', refreshToken);
    print('Success to save token and refreshToken');
  }

  Future<void> login(String username, String password) async {
    _setLoading(true);
    try {
      final result = await _authRepository.login(username, password);
      _setErrorMessage(null);

      final data = jsonDecode(result);
      _setData(data);

      final token = data['accessToken'];
      final refreshToken = data['refreshToken'];
      await _saveToLocalStorage(token, refreshToken);

    } catch (e) {
      _setErrorMessage('Gagal Login');
    } finally {
      _setLoading(false);
    }
  }
}
