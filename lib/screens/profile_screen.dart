import 'package:flutter/material.dart';
import 'package:login_app/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  final String token;

  ProfileScreen({required this.token});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? userInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  void _fetchUserInfo() async {
    final data = await _authService.fetchUserInfo(widget.token);
    setState(() {
      userInfo = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil de l\'Utilisateur'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : userInfo != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Nom'),
              subtitle: Text('${userInfo!['firstName']} ${userInfo!['lastName']}'),
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Rôle'),
              subtitle: Text(userInfo!['role']),
            ),
          ],
        ),
      )
          : const Center(
        child: Text('Erreur lors de la récupération des informations utilisateur'),
      ),
    );
  }
}
