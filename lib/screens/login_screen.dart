import 'package:flutter/material.dart';
import 'package:login_app/screens/profile_screen.dart';
import 'package:login_app/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  // final Map<String, String> _users = {
  //   'user@example.com': 'userpass',
  //   'admin@example.com': 'adminpass',
  // };
  final Map<String, Map<String, dynamic>> _users = {
    'user@example.com': {
      'password': 'userpass',
      'firstName': 'Jane',
      'lastName': 'Doe',
      'role': 'User',
    },
    'admin@example.com': {
      'password': 'adminpass',
      'firstName': 'Admin',
      'lastName': 'User',
      'role': 'Admin',
    },
  };

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String email = _emailController.text;
      String password = _passwordController.text;
      final user = await _authService.login(email, password);
      setState(() {
        _isLoading = false;
      });
      if (user != null) {
        // Connexion réussie avec informations supplémentaires
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(
              email: email,
              firstName: user['firstName'],
              lastName: user['lastName'],
              role: user['role'],
            ),
          ),
        );
      } else {
        // Connexion échouée
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erreur'),
            content: Text('Email ou mot de passe incorrect'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // mail
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.mail),
                  ),
                  //keyboardType: TextInputType.visiblePassword,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                  // Validation de l'email
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre email';
                    }
                    // Regex simple pour valider l'email
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Veuillez entrer un email valide';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Champ Mot de Passe
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.lock),
                  ),
                  obscureText: true, // Masquer le texte
                  validator: (value) {
                    // Validation du mot de passe
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    }
                    if (value.length < 6) {
                      return 'Le mot de passe doit contenir au moins 6 caractères';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        child: Text('Se connecter'),
                      ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
    );
  }
}
