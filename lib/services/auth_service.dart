import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class AuthService {
  final String _baseUrl;

  AuthService() : _baseUrl = AuthService.getBaseUrl();

  static String getBaseUrl() {
    if (kIsWeb) {
      return 'http://localhost:3000';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    } else if (Platform.isIOS) {
      return 'http://localhost:3000';
    } else {
      return 'http://localhost:3000';
    }
  }// 10.0.2.2 pour un émulateur Android

  // Fonction pour s'authentifier et obtenir un token
  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['token']; // Retourne le token
      } else {
        print('Erreur lors de l\'authentification : ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erreur lors de la connexion : $e');
      return null;
    }
  }

  // Fonction pour récupérer les informations utilisateur
  Future<Map<String, dynamic>?> fetchUserInfo(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/info'),
        headers: {
          'Authorization': 'Bearer $token', // Ajout du token dans l'en-tête
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Retourne les données utilisateur
      } else {
        print('Erreur lors de la récupération des informations utilisateur : ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erreur : $e');
      return null;
    }
  }
}
