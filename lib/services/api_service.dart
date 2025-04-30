import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const baseUrl = 'http://192.168.73.5:3000';

  Future<http.Response> get(String endpoint) async {
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);

    if(response.statusCode == 401){
      // Token expired
      final refreshed = await _refreshToken();
      if(refreshed) {
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
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json',
    };
  }

  Future<bool> _refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');
    if (refreshToken == null) return false;

    final response = await http.post(
      Uri.parse('$baseUrl/auth/refresh-token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({ 'refreshToken': refreshToken })
    );

    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if(data['accessToken'] != null) {
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