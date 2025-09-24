import 'package:flutter/material.dart';
import 'package:profile_hub/core/utils/extension/size_extension/size_extension.dart';
import 'package:profile_hub/core/utils/palette/palette.dart';

class InfoChipWidget extends StatelessWidget {
  const InfoChipWidget({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.03,
        vertical: context.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Palette.whiteColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //-- icon
          Icon(icon, size: 12, color: Palette.whiteColor.withOpacity(0.7)),
          const SizedBox(width: 4),

          //-- text
          Text(
            text,
            style: TextStyle(color: Palette.whiteColor.withOpacity(0.7), fontSize: 10),
          ),
        ],
      ),
    );
  }
}
