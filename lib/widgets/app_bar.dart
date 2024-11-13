// FILE: custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:mood_tracker/screens/user_page/user.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String imagePath;
  final String titleText;
  final Widget targetPage;
  final bool useBorder;
  final double imageHeight;
  final Color backgroundColor;
  final Color textColor;
  final Color? imageColor;
  final bool useImage;

  const CustomAppBar({
    super.key,
    required this.imagePath,
    required this.titleText,
    required this.textColor,
    required this.targetPage,
    this.imageColor,
    this.useBorder = true,
    this.imageHeight = 48,
    this.backgroundColor = Colors.white,
    this.useImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
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
          if (useImage)
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const UserScreen(),
                    transitionDuration: Duration.zero,
                  ),
                );
              },
              child: Image.asset(
                imagePath,
                height: imageHeight,
                color: imageColor,
              ),
            ),
          if (useImage) const SizedBox(width: 10),
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
