// FILE: custom_app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String imagePath;
  final String titleText;
  final Widget targetPage;
  final bool useBorder;
  final double imageHeight;
  final Color backgroundColor;
  final Color textColor;
  final Color? imageColor;

  const CustomAppBar({
    super.key,
    required this.imagePath,
    required this.titleText,
    required this.targetPage,
    required this.textColor,
    this.imageColor,
    this.useBorder = true,
    this.imageHeight = 48,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      toolbarHeight: 50.0,
      shape: useBorder
          ? Border(
              bottom: BorderSide(
                color: Color(0xFFE68C52).withOpacity(0.5),
                width: 2.0,
              ),
            )
          : null,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => targetPage),
              );
            },
            child: Image.asset(
              imagePath,
              height: imageHeight,
              color: imageColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            titleText,
            style: TextStyle(
              fontSize: 20,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
