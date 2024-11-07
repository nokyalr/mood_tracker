import 'package:flutter/material.dart';
import 'package:mood_tracker/widgets/confirm_button.dart';
import 'package:mood_tracker/widgets/text_field.dart';
import 'user.dart';
import 'package:mood_tracker/widgets/app_bar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        imagePath: 'assets/images/back.png',
        titleText: 'Edit Profile',
        targetPage: const UserScreen(),
        useBorder: true,
        imageHeight: 28,
        backgroundColor: Colors.white,
        textColor: Color(0xFFE68C52),
        imageColor: Color(0xFFE68C52),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 120,
                      child: Center(
                        child: Image.asset('assets/images/people1.png'),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Change Avatar',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFE68C52),
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      controller: _nicknameController,
                      hintText: 'nickname',
                      prefixIconPath: 'assets/images/user.png',
                      showVisibilityIcon: false,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _usernameController,
                      hintText: 'username',
                      prefixIconPath: 'assets/images/user.png',
                      showVisibilityIcon: false,
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
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
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
