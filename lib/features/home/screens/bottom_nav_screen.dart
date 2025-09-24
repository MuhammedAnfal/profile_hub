// app.dart
import 'package:flutter/material.dart';
import 'package:profile_hub/core/utils/palette/palette.dart';
import 'package:profile_hub/features/home/screens/home_screen.dart';
import 'package:profile_hub/features/home/screens/profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  final List<Widget> _screens = [const HomeScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.blackColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade300, Colors.indigo.shade700],
          ),
          boxShadow: [
            BoxShadow(
              color: Palette.blackColor.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Palette.whiteColor,
            unselectedItemColor: Palette.whiteColor.withOpacity(0.6),
            items: [
              //-- bottom navigation bar items

              //-- home
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == 0
                        ? Palette.whiteColor.withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: const Icon(Icons.people_alt_rounded),
                ),
                label: 'Home',
              ),

              //-- profile
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == 1
                        ? Palette.whiteColor.withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: const Icon(Icons.person_rounded),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
