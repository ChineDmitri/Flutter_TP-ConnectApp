// lib/services/auth_service.dart
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AuthService {
  // Fonction de hachage du mot de passe
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Tableau associatif local des utilisateurs
  final Map<String, Map<String, dynamic>> _users = {
    'user@example.com': {
      'password': hashPassword('userpass'),
      'firstName': 'Jane',
      'lastName': 'Doe',
      'role': 'User',
    },
    'admin@example.com': {
      'password': hashPassword('adminpass'),
      'firstName': 'Admin',
      'lastName': 'User',
      'role': 'Admin',
    },
  };

  // Méthode de connexion
  // Rend la méthode asynchrone pour permettre une intégration future avec des appels API
  Future<Map<String, dynamic>?> login(String email, String password) async {
    if (_users.containsKey(email)) {
      String hashedPassword = hashPassword(password);
      if (_users[email]!['password'] == hashedPassword) {
        return _users[email];
      }
    }
    return null;
  }

  // get role
  String? getUserRole(String email) {
    return _users[email]?['role'];
  }
}
