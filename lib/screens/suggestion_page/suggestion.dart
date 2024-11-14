import 'package:flutter/material.dart';
import 'package:mood_tracker/widgets/app_bar.dart';
import 'package:mood_tracker/widgets/text_field.dart';
import '../home_page/home.dart';
import '../calendar_page/calendar.dart';
import '../user_page/user.dart';
import '../../widgets/bottom_navigation.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  SuggestionScreenState createState() => SuggestionScreenState();
}

class SuggestionScreenState extends State<SuggestionScreen> {
  int _selectedIndex = 2;
  final TextEditingController _topicController = TextEditingController();
  String searchQuery = '';

  // Sample articles
  final List<Map<String, String>> articles = [
    {
      'title': 'Reflect on Your Achievements',
      'abstract':
          'Take a moment to write down some recent achievements, big or small. Reflecting on what you'
              've accomplished can help you recognize your growth and feel even prouder of your journey....',
    },
    {
      'title': 'Share Your Success with a Friend or Family...',
      'abstract':
          'Celebrate your accomplishments by sharing them with someone close. Talking about your success with someone supportive can amplify your pride and create positive memories...',
    },
    {
      'title': 'Set New Goals to Build on Your Success',
      'abstract': 'Now that you’re in a proud mindset, it'
          's a perfect time to set new goals. Think of ways to further challenge yourself or improve, keeping the momentum going...',
    },
    {
      'title': 'Practice Gratitude for the Journey',
      'abstract':
          'Take a few minutes to reflect on the journey that led to your proud moment. Practice gratitude for the experiences, people, and effort that contributed to your success.',
    },
    {
      'title': 'Building Healthy Relationships',
      'abstract': 'Strong relationships contribute to emotional well-being.',
    },
  ];

  List<Map<String, String>> displayedArticles = [];

  @override
  void initState() {
    super.initState();
    displayedArticles = List.from(articles); // Initialize displayed articles
  }

  void _filterArticles(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        displayedArticles = List.from(articles); // Reset to original articles
      } else {
        displayedArticles = articles.where((article) {
          return article['title']!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

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
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        imagePath: 'assets/images/back.png',
        titleText: 'Suggestion',
        targetPage: const UserScreen(),
        useBorder: false,
        imageHeight: 28,
        textColor: Color(0xFFE68C52),
        imageColor: Color(0xFFE68C52),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: _topicController,
                hintText: 'search topic',
                prefixIconPath: 'assets/images/search.png',
                showVisibilityIcon: false,
                onChanged: _filterArticles, // Call filter function
              ),
              const SizedBox(height: 10),
              const Text(
                'Based on your recent mood:',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFE68C52),
                ),
              ),
              Container(
                height: 2,
                color: const Color(0xFFE68C52),
                margin: const EdgeInsets.only(top: 4, bottom: 4),
              ),
              const SizedBox(height: 10),
              // Display filtered articles
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: displayedArticles.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE68C52)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayedArticles[index]['title'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE68C52),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Divider(color: Color(0xFFE68C52)),
                        Text(
                          displayedArticles[index]['abstract'] ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF000000),
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
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
