import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../user_page/friends.dart';
import '../../screens/login.dart';
import '../home_page/home.dart';
import '../calendar_page/calendar.dart';
import '../suggestion_page/suggestion.dart';
import '../user_page/edit_profile.dart';
import '../../widgets/bottom_navigation.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  UserScreenState createState() => UserScreenState();
}

class UserScreenState extends State<UserScreen> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CalendarScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SuggestionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 150.0,
        backgroundColor: Colors.white,
        shape: Border(
          bottom: BorderSide(
            color: Color(0xFFE68C52).withOpacity(0.5),
            width: 2.0,
          ),
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/people1.png',
              height: 110,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Annie',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFFE68C52),
                  ),
                ),
                const Text(
                  '@annie_',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFFE68C52),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Edit Profile ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.8),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen()),
                            );
                          },
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.asset(
                      'assets/images/edit.png',
                      height: 14,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/friends.png',
                    height: 24,
                  ),
                  const SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                      text: 'Friends',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FriendsScreen()),
                          );
                        },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Image.asset(
                    'assets/images/logout.png',
                    height: 24,
                  ),
                  const SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                      text: 'Sign out',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
