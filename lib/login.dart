import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Create storage
  final storage = new FlutterSecureStorage();

  Future<void> _login() async {
    var url = Uri.parse(
        '${const String.fromEnvironment('BACKEND_URL', defaultValue: 'http://10.0.2.2:8000')}/pelajar/login'
    );
    var data =jsonEncode( {
      "email": "${_emailController.text}",
      "password": "${_passwordController.text}"
    });
    var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: data);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      var accessToken = responseBody['access_token'];
      storage.write(key: 'jwt', value: accessToken);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } else {
      var errorResponse = json.decode(response.body);
      var errorMessage = errorResponse['detail'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Swift E-Learning',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Text('Login'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("forget password");
                    },
                    child: Text(
                      "Lupa password?",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.blue
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
