import 'package:flutter/material.dart';
import 'package:todo_app/data/repositories/auth_repository.dart';

class RegisterViewModel2 {
  final AuthRepository _authRepository = AuthRepository();

  Future<String> register(String email, String username, String password) async {
    try {
      return await _authRepository.register(email, username, password);
    } catch (e) {
      return 'Error: $e';
    }
  }
}

class RegisterViewModel extends ChangeNotifier{
  // ChangeNotifier = kelas bawaan dari FLutter untuk MVVM or state management
  // kelola perubahan data ke UI
  // notifikasi perubahan = notifyListeners agar tidak ada pembaruan seluruh widget
  final AuthRepository _authRepository;// AuthRepository = tipe data Konkrit

  RegisterViewModel(this._authRepository);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading; // akan dipakai sebagai data provider pada screen lain (see main.dart)
  String? get errorMessage => _errorMessage;  // akan dipakai sebagai data provider pada screen lain (see main.dart)

  void _setLoading(bool value) {// parameter sifat = boolean
    _isLoading = value;
    notifyListeners();// method dari ChangeNotifier
    // metode dari ChangeNotifier beritahu bahwa state atau data telah berubah, dan widget lainnya bisa diubah
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> register(String email, String username, String password) async {
    _setLoading(true);

    try {
      final result = await _authRepository.register(email, username, password);
      if(result == 'Success') {
        _setErrorMessage(null);
      } else {
        _setErrorMessage('Gagal Registrasi');
      }
    } catch (e) {
      _setErrorMessage('Terjadi Kesalahan $e');
    } finally {
      _setLoading(false);
    }
  }
}