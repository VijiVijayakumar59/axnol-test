// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>?> login(String email, String password) async {
    const url = 'http://axnoldigitalsolutions.in/Training/api/login';

    final Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        return {'error': 'Invalid email or password', 'status': response.statusCode.toString()};
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
