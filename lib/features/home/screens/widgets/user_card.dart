// widgets/user_card.dart
import 'package:flutter/material.dart';
import 'package:profile_hub/core/utils/extension/size_extension/size_extension.dart';
import 'package:profile_hub/core/utils/palette/palette.dart';
import 'package:profile_hub/features/home/screens/user_details_screen.dart';
import 'package:profile_hub/features/home/screens/widgets/info_chip.dart';
import 'package:profile_hub/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.shade800.withOpacity(0.6),
            Colors.indigo.shade800.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Palette.whiteColor.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Palette.blackColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            //-- navigate to userdetalis page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserDetailsPage(user: user)),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //-- profile
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade400, Colors.purple.shade400],
                        ),
                      ),

                      //-- user name first letter
                      child: Center(
                        child: Text(
                          user.name![0].toUpperCase(),
                          style: const TextStyle(
                            color: Palette.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    //-- name and email
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name!,
                            style: const TextStyle(
                              color: Palette.whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email!.toLowerCase(),
                            style: TextStyle(
                              color: Palette.whiteColor.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //-- Icon
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Palette.whiteColor.withOpacity(0.6),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                //-- Additional Info
                Row(
                  children: [
                    InfoChipWidget(icon: Icons.phone_rounded, text: user.phone!),
                    SizedBox(width: context.width * 0.03),
                    InfoChipWidget(icon: Icons.language_rounded, text: user.website!),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
