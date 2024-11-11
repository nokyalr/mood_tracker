import 'package:flutter/material.dart';
import '../home_page/home.dart';
import '../suggestion_page/suggestion.dart';
import '../user_page/user.dart';
import '../../widgets/bottom_navigation.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  int _selectedIndex = 1;
  int _currentMonth = DateTime.now().month; // Menyimpan bulan saat ini
  int _currentYear = DateTime.now().year; // Menyimpan tahun saat ini

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SuggestionScreen()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserScreen()),
      );
    }
  }

  // Fungsi untuk mengubah bulan
  void _changeMonth(int delta) {
    setState(() {
      _currentMonth += delta;

      // Cek jika bulan melebihi 12 (Desember) atau kurang dari 1 (Januari)
      if (_currentMonth > 12) {
        _currentMonth = 1;
        _currentYear++;
      } else if (_currentMonth < 1) {
        _currentMonth = 12;
        _currentYear--;
      }
    });
  }

  // Fungsi untuk menghitung jumlah hari dalam bulan tertentu
  int _getDaysInMonth(int month, int year) {
    // Menggunakan DateTime untuk mendapatkan jumlah hari dalam bulan
    int daysInMonth = DateTime(year, month + 1, 0).day;
    return daysInMonth;
  }

  @override
  Widget build(BuildContext context) {
    // Mengubah nama bulan berdasarkan _currentMonth
    String monthName = '';
    switch (_currentMonth) {
      case 1:
        monthName = 'January';
        break;
      case 2:
        monthName = 'February';
        break;
      case 3:
        monthName = 'March';
        break;
      case 4:
        monthName = 'April';
        break;
      case 5:
        monthName = 'May';
        break;
      case 6:
        monthName = 'June';
        break;
      case 7:
        monthName = 'July';
        break;
      case 8:
        monthName = 'August';
        break;
      case 9:
        monthName = 'September';
        break;
      case 10:
        monthName = 'October';
        break;
      case 11:
        monthName = 'November';
        break;
      case 12:
        monthName = 'December';
        break;
    }

    // Menghitung jumlah hari dalam bulan yang sedang dipilih
    int daysInMonth = _getDaysInMonth(_currentMonth, _currentYear);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      _changeMonth(-1); // Menekan tombol back, bulan sebelumnya
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                    iconSize: 30,
                    color: Color(0xFFE68C52),
                  ),
                  Text(
                    '$monthName $_currentYear',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE68C52),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _changeMonth(
                          1); // Menekan tombol forward, bulan berikutnya
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                    iconSize: 30,
                    color: Color(0xFFE68C52),
                  ),
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.0,
                ),
                itemCount: daysInMonth, // Menampilkan jumlah hari yang benar
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFA6A6A6),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}', // Menampilkan tanggal sesuai urutan
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE68C52), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Menambahkan tulisan "Mood Stats"
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        'Mood Stats',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE68C52),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/images/very-bad.png',
                          height: 45,
                        ),
                        Image.asset('assets/images/poor.png', height: 45),
                        Image.asset('assets/images/medium.png', height: 45),
                        Image.asset('assets/images/good.png', height: 45),
                        Image.asset('assets/images/excellent.png', height: 45),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Row for mood color bar with border radius on edges
                    Row(
                      children: List.generate(5, (index) {
                        return Expanded(
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: [
                                Color(0xFFF64927),
                                Color(0xFFF9C26D),
                                Color(0xFFFFDE4B),
                                Color(0xFFC9E23D),
                                Color(0xFF76D650),
                              ][index],
                              borderRadius: BorderRadius.horizontal(
                                left: index == 0
                                    ? Radius.circular(10)
                                    : Radius.zero,
                                right: index == 4
                                    ? Radius.circular(10)
                                    : Radius.zero,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
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
