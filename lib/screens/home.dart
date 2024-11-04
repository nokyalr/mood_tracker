import 'package:flutter/material.dart';
import 'calendar.dart';
import 'suggestion.dart';
import 'user.dart';
import '../widgets/bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const CalendarScreen(),
          fullscreenDialog: true,
        ),
      );
    } else if (index == 2) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SuggestionScreen()),
        (Route<dynamic> route) => false,
      );
    } else if (index == 3) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const UserScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xFFE68C52),
            width: 3.0,
          ),
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/people_16086025.png',
              height: 52,
            ),
            const SizedBox(width: 10),
            const Text(
              'Welcome back, Annie!',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFFE68C52),
              ),
            ),
          ],
        ),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(40.0),
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
