import 'package:flutter/material.dart';

class SellerAvatar extends StatelessWidget {
  final String imagePath;
  final double radius;

  const SellerAvatar({
    super.key,
    required this.imagePath,
    this.radius = 48,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + 4, // ketebalan ring 4
      backgroundColor: const Color(0xFFB87A5A),
      child: CircleAvatar(
        radius: radius,
        backgroundImage: AssetImage(imagePath),
      ),
    );
  }
}