// screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:profile_hub/core/utils/palette/palette.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade900, Palette.blackColor],
          ),
        ),
        child: Column(
          children: [
            // Custom App Bar
            Container(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade800.withOpacity(0.8), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, color: Palette.whiteColor, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: Palette.whiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Profile Content
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile Icon
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.deepPurple.shade400, Colors.purple.shade300],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: Palette.whiteColor.withOpacity(0.3),
                          width: 3,
                        ),
                      ),
                      child: Icon(Icons.person, color: Palette.whiteColor, size: 60),
                    ),
                    const SizedBox(height: 20),

                    // User Name
                    Text(
                      'John Doe',
                      style: TextStyle(
                        color: Palette.whiteColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Email or additional info
                    Text(
                      'john.doe@example.com',
                      style: TextStyle(
                        color: Palette.whiteColor.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
