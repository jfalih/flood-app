import 'package:flood/ui/screens/history_screen.dart';
import 'package:flood/ui/screens/home_screen.dart';
import 'package:flood/ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int selectedIndex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          selectedItemColor: Color(0xFFC10505),
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            selectedIndex = index;
            if (mounted) {
              setState(() {});
            }
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.houseMedical), label: "Beranda"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.history), label: "History"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.user), label: "Account"),
          ]),
    );
  }
}