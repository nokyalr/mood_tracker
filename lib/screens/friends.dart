import 'package:flutter/material.dart';
import 'package:mood_tracker/screens/user.dart';
import 'package:mood_tracker/widgets/text_field.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  FriendsScreenState createState() => FriendsScreenState();
}

class FriendsScreenState extends State<FriendsScreen> {
  final TextEditingController _friendController = TextEditingController();
  final TextEditingController _searchUsernameController =
      TextEditingController();
  String searchQuery = '';
  bool showOverlay = false;
  List<Map<String, String>> friends = [
    {
      'nickname': 'Sam',
      'username': '@dailysam',
      'profileImage': 'assets/images/people5.png',
    },
    {
      'nickname': 'Ashila',
      'username': '@funnyacell',
      'profileImage': 'assets/images/people1.png',
    },
    {
      'nickname': 'John',
      'username': '@johnside',
      'profileImage': 'assets/images/people3.png',
    },
    {
      'nickname': 'Esther',
      'username': '@realesther',
      'profileImage': 'assets/images/people6.png',
    },
    {
      'nickname': 'Mike',
      'username': '@literallymike',
      'profileImage': 'assets/images/people2.png',
    },
    {
      'nickname': 'Anne',
      'username': '@anneliese',
      'profileImage': 'assets/images/people1.png',
    },
    {
      'nickname': 'George',
      'username': '@extremelylucky',
      'profileImage': 'assets/images/people3.png',
    },
    {
      'nickname': 'Andrew',
      'username': '@heyitsandrew',
      'profileImage': 'assets/images/people2.png',
    },
    {
      'nickname': 'Joyce',
      'username': '@janajoyce',
      'profileImage': 'assets/images/people4.png',
    },
    {
      'nickname': 'Smith',
      'username': '@sandsmith',
      'profileImage': 'assets/images/people3.png',
    },
    {
      'nickname': 'Nial',
      'username': '@soundofnial',
      'profileImage': 'assets/images/people2.png',
    },
  ];

  List<Map<String, String>> searchResults = [];

  // Keep the original friends list intact
  List<Map<String, String>> displayedFriends = [];

  @override
  void initState() {
    super.initState();
    displayedFriends = List.from(friends); // Initialize displayed friends
  }

  Future<void> _fetchFriendsFromDatabase(String username) async {
    await Future.delayed(const Duration(seconds: 1));
    final results = friends
        .where((friend) =>
            friend['username']!.toLowerCase().contains(username.toLowerCase()))
        .toList();

    setState(() {
      searchResults = results;
    });
  }

  void _openAddFriendOverlay() {
    setState(() {
      showOverlay = true;
      _searchUsernameController.clear();
      searchResults = [];
    });
  }

  void _closeAddFriendOverlay() {
    setState(() {
      showOverlay = false;
      _searchUsernameController.clear();
      searchResults = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50.0,
        backgroundColor:
            showOverlay ? Colors.black.withOpacity(0.3) : Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserScreen()),
                      );
                    },
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
                const SizedBox(width: 10),
                const Text(
                  'Friends',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFFE68C52),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _friendController,
                        hintText: 'search name',
                        prefixIconPath: 'assets/images/search.png',
                        showVisibilityIcon: false,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                            // Update displayed friends based on main search
                            displayedFriends = friends
                                .where((friend) => friend['nickname']!
                                    .toLowerCase()
                                    .contains(searchQuery.toLowerCase()))
                                .toList();
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Friends - ${friends.length}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFE68C52),
                        ),
                      ),
                      Container(
                        height: 2,
                        color: const Color(0xFFE68C52),
                        margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      ),
                    ],
                  ),
                ),
                // Display list of friends based on main search
                Column(
                  children: displayedFriends.map((friend) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: ClipOval(
                              child: Image.asset(
                                friend['profileImage'] ??
                                    'assets/images/people0.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                friend['nickname'] ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                              Text(
                                friend['username'] ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFA6A6A6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          if (showOverlay)
            GestureDetector(
              onTap: _closeAddFriendOverlay,
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          if (showOverlay)
            Center(
              child: GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.5,
                    margin: const EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              IconButton(
                                onPressed: _closeAddFriendOverlay,
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Color(0xFFE68C52),
                                ),
                              ),
                              const Text(
                                'Add Friend',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE68C52),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _searchUsernameController,
                            hintText: 'search username',
                            prefixIconPath: 'assets/images/search.png',
                            showVisibilityIcon: false,
                            onChanged: (value) async {
                              // Search only for usernames in the overlay
                              await _fetchFriendsFromDatabase(value);
                            },
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView.builder(
                              itemCount: searchResults.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: ClipOval(
                                    child: Image.asset(
                                      searchResults[index]['profileImage'] ??
                                          'assets/images/people0.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                      searchResults[index]['nickname'] ?? ''),
                                  subtitle: Text(
                                      searchResults[index]['username'] ?? ''),
                                  onTap: () {
                                    // Action when a friend is tapped
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: !showOverlay
          ? FloatingActionButton(
              onPressed: _openAddFriendOverlay,
              backgroundColor: const Color(0xFFE68C52),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
