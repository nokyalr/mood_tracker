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

  final List<Map<String, String>> posts = [
    {
      'username': '@anniey',
      'time': '20 hours ago',
      'description':
          'Today, 10 October several tasks had been done pretty good :)',
      'date': '6/10/2024',
      'moodImagePath': 'assets/images/good.png',
      'profileImagePath': 'assets/images/people1.png',
      'comments': '0'
    },
    {
      'username': '@stevia_',
      'time': '2 days ago',
      'description': 'having some achievement!',
      'date': '1/10/2024',
      'moodImagePath': 'assets/images/excellent.png',
      'profileImagePath': 'assets/images/people5.png',
      'comments': '2'
    },
    {
      'username': '@mar_lize',
      'time': '1 days ago',
      'description': 'got an accident :(',
      'date': '10/10/2024',
      'moodImagePath': 'assets/images/very-bad.png',
      'profileImagePath': 'assets/images/people3.png',
      'comments': '5'
    },
    {
      'username': '@anniey',
      'time': '20 hours ago',
      'description':
          'Today, 10 October several tasks had been done pretty good :)',
      'date': '6/10/2024',
      'moodImagePath': 'assets/images/good.png',
      'profileImagePath': 'assets/images/people1.png',
      'comments': '0'
    },
    {
      'username': '@stevia_',
      'time': '2 days ago',
      'description': 'having some achievement!',
      'date': '1/10/2024',
      'moodImagePath': 'assets/images/excellent.png',
      'profileImagePath': 'assets/images/people5.png',
      'comments': '2'
    },
    {
      'username': '@mar_lize',
      'time': '1 days ago',
      'description': 'got an accident :(',
      'date': '10/10/2024',
      'moodImagePath': 'assets/images/very-bad.png',
      'profileImagePath': 'assets/images/people3.png',
      'comments': '5'
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const HomeScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const CalendarScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const SuggestionScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const UserScreen(),
          transitionDuration: Duration.zero,
        ),
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
      body: ListView.builder(
        itemCount: posts.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          final post = posts[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE68C52)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage:
                                    AssetImage(post['profileImagePath'] ?? ''),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post['username'] ?? '',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFE68C52),
                                      ),
                                    ),
                                    Text(
                                      post['time'] ?? '',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFFA6A6A6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Description
                          Text(
                            post['description'] ?? '',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          // Date
                          Text(
                            post['date'] ?? '',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFFA6A6A6)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        post['moodImagePath'] ?? '',
                        width: 120, // Updated width
                        height: 120, // Updated height
                      ),
                    ),
                  ],
                ),
                Divider(color: Color(0xFFE68C52)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Add a comment...',
                        style: TextStyle(color: Color(0xFFA6A6A6)),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.comment, color: Color(0xFFA6A6A6)),
                        const SizedBox(width: 4),
                        Text(
                          post['comments'] ?? '0',
                          style: TextStyle(color: Color(0xFFA6A6A6)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
