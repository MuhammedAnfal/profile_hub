import 'package:flutter/material.dart';
import 'package:profile_hub/core/utils/extension/size_extension/size_extension.dart';
import 'package:profile_hub/core/utils/palette/palette.dart';

class CustomErrorPage extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onRetry;
  const CustomErrorPage({
    required this.title,
    required this.description,
    required this.onRetry,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //-- icon of the error
          const Icon(Icons.error_outline, color: Palette.redColor, size: 80),
          SizedBox(height: context.height * 0.03),

          //-- error text
          Text(
            title,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Palette.whiteColor,
            ),
          ),
          SizedBox(height: context.height * 0.02),
          //-- retry button
          ElevatedButton(
            onPressed: onRetry,
            child: Text("Retry", style: TextStyle(color: Palette.blackColor)),
          ),
        ],
      ),
    );
  }
}
