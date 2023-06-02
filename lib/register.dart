import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swift_elearning/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'components/env.dart';


final storage = FlutterSecureStorage();

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _schoolController = TextEditingController();
  String? _selectedMajor;
  bool _userAgreed = false;
  


  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            child: Text("Daftar ke Swift E-Learning",
            style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder(),),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder(),),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _fullNameController,
            decoration: const InputDecoration(labelText: 'Full Name',border: OutlineInputBorder(),),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _schoolController,
            decoration: const InputDecoration(labelText: 'School', border: OutlineInputBorder(),),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your school name';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            value: _selectedMajor,
            onChanged: (value) {
              setState(() {
                _selectedMajor = value;
              });
            },
            items: <String>['IPA', 'IPS']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: const InputDecoration(
              labelText: 'Major',
              border: OutlineInputBorder(),
              
              ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your major';
              }
              return null;
            },
          ),
          CheckboxListTile(
            title: const Text('Saya setuju dengan segala syarat dan ketentuan yang berlaku'),
            value: _userAgreed,
            onChanged: (bool? value) {
              setState(() {
                _userAgreed = value ?? false;
              });
            },
          ),

          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true && _userAgreed == true) {
                  _submitForm();
                  
                } else {
                  setState(() {
                    _userAgreed = false; // uncheck the box if validation fails
                  });
                  if (_userAgreed == false) {
                    // show an error message if the user has not agreed to the terms and conditions
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Anda harus setuju dengan syarat dan ketentuan untuk melanjutkan.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Register'),
              ),
            ),
          )
        ],
      ),
    );
      
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

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(child: Container(
          height: 500,
          child: _buildForm()
          )
        )
        )
    );
  }

  void _submitForm() async {
    String url = '${Env.instance.get("API_URL")!}/pelajar/register';

    // The body of the request is usually a JSON object
    final Map<String, dynamic> requestBody = {
      "email": _emailController.text,
      "nama_lengkap": _fullNameController.text,
      "raw_password": _passwordController.text,
      "asal_sekolah": _schoolController.text,
      "jurusan": _selectedMajor!
    };

    // Encode the request body as JSON
    final String jsonBody = jsonEncode(requestBody);

    // Make the POST request
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
      //mengubah halaman
      _showMyDialog();
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseBody['detail']),
          backgroundColor: Colors.red,
        ),
      );
    }
    
  }

  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Berhasil'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Mohon aktifkan akun anda dengan membuka link yang telah dikirim pada email anda.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      );
    },
  );
}

}


