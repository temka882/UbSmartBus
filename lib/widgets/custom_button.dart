import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget icon; // The icon is now the image (or any Widget)
  final VoidCallback onTap;

  const CustomButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Handle the tap
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.transparent, // Transparent background
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          // Center the image in the button
          child: icon, // Only show the image
        ),
      ),
    );
  }
}
