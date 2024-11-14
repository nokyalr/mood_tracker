import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker/screens/home_page/home.dart';
import 'package:mood_tracker/screens/register.dart';
import 'package:mood_tracker/widgets/text_field.dart';
import 'package:mood_tracker/widgets/confirm_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mood_tracker/util/config/config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginUser() async {
    // Validasi Username (pastikan tidak kosong)
    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username tidak boleh kosong")),
      );
      return;
    }

    // Validasi Password (pastikan tidak kosong)
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password tidak boleh kosong")),
      );
      return;
    }

    // Mengirimkan data login ke server PHP menggunakan HTTP POST
    final url = Uri.http(AppConfig.API_HOST, '/moodtracker/login.php');
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
        MaterialPageRoute(builder: (context) => const HomeScreen()),
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                      'Sign in',
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
                      'Please login to continue',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFA6A6A6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: _usernameController,
                  hintText: 'username',
                  prefixIconPath: 'assets/images/user.png',
                  showVisibilityIcon: false,
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ConfirmButton(
                      text: 'confirm',
                      onPressed: () async {
                        await _loginUser();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 160),
                RichText(
                  text: TextSpan(
                    text: 'Don’t have an account? ',
                    style:
                        const TextStyle(color: Color(0xFFA6A6A6), fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: const TextStyle(
                            color: Color(0xFFE68C52), fontSize: 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
