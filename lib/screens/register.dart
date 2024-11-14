import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker/screens/login.dart';
import 'package:mood_tracker/widgets/text_field.dart';
import 'package:mood_tracker/widgets/confirm_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mood_tracker/util/config/config.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Mengubah nama method menjadi _signUp
  Future<void> _signUp() async {
    // Mengecek apakah password dan konfirmasi password cocok
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Password dan Konfirmasi Password tidak cocok")),
      );
      return;
    }

    // Validasi Username (pastikan tidak kosong)
    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username tidak boleh kosong")),
      );
      return;
    }

    // Mengirimkan data pendaftaran ke server PHP menggunakan HTTP POST
    final url = Uri.http(AppConfig.API_HOST, '/moodtracker/register.php');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    // Mengecek respon dari server
    final responseBody = json.decode(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseBody['message'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        height: 60,
                        child: Image.asset(
                          'assets/images/back.png',
                          color: const Color(0xFFE68C52),
                          width: 42,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 60),
                          SizedBox(
                            height: 60,
                            child: Image.asset('assets/images/smile.png'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE68C52),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Please register to continue',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFA6A6A6),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Input Username
                      CustomTextField(
                        controller: _usernameController,
                        hintText: 'username',
                        prefixIconPath: 'assets/images/user.png',
                        showVisibilityIcon: false,
                      ),
                      const SizedBox(height: 20),
                      // Input Password
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'password',
                        prefixIconPath: 'assets/images/padlock.png',
                        obscureText: true,
                        isPasswordVisible: _isPasswordVisible,
                        onSuffixIconPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        hintText: 'confirm password',
                        prefixIconPath: 'assets/images/padlock.png',
                        obscureText: true,
                        showVisibilityIcon: false,
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ConfirmButton(
                            text: 'confirm',
                            onPressed: () async {
                              await _signUp();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 80),
                      RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: const TextStyle(
                              color: Color(0xFFA6A6A6), fontSize: 16),
                          children: [
                            TextSpan(
                              text: 'Sign in',
                              style: const TextStyle(
                                  color: Color(0xFFE68C52), fontSize: 16),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
