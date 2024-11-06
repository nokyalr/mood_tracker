import 'package:flutter/material.dart';
import '../calendar_page/calendar.dart';
import '../suggestion_page/suggestion.dart';
import '../user_page/user.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/app_bar.dart';

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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        imagePath: 'assets/images/people1.png',
        titleText: 'Welcome back, Annie!',
        targetPage: const UserScreen(),
        useBorder: true,
        imageHeight: 48,
        backgroundColor: Colors.white,
        textColor: Color(0xFFE68C52),
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
