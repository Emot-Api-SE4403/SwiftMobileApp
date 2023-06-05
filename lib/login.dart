import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'components/env.dart';
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
  final storage = FlutterSecureStorage();

  sendMessage(String text) {
    return SnackBar(content: Text(text));
  }

  Future<void> _login() async {
    String url = '${Env.instance.get("API_URL")!}/pelajar/login';

    // The body of the request is usually a JSON object
    final Map<String, dynamic> requestBody = {
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    // Encode the request body as JSON
    final String jsonBody = jsonEncode(requestBody);

    // Make the POST request
    try{
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonBody,
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      // Check if the request was successful
      if (response.statusCode == 200) {
        storage.write(key: 'jwt', value: responseBody['access_token']);

        //mengubah halaman
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(sendMessage(responseBody['detail']));
      }
    } catch (exc){
      ScaffoldMessenger.of(context).showSnackBar(sendMessage('Unknown exception: $exc'));
    }
    

  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
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
                      _showResetPasswordDialog();
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
  

   Future _showResetPasswordDialog() async {
    TextEditingController forgotenEmail = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Masukan email anda'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: forgotenEmail,
                  decoration: InputDecoration(
                    hintText: 'contoh@example.com',
                    hintStyle: TextStyle(color: Colors.blue),
                  ),
                ),
                Text("Jika email yang anda masukan benar, password anda akan di reset."),
                Text("Untuk keterangan lebih lanjut, lihat email yang kami kirim")

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Submit'),
              onPressed: () async {
                await _reset_pw(forgotenEmail.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
  Future _reset_pw(String text) async {
    String url = '${Env.instance.get("API_URL")!}/user/resetpassword?email=$text';

    // Make the POST request
    final response = await http.post(
      Uri.parse(url),
    );
  }
}
