import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSignInButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;

  const CustomSignInButton({
    super.key,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          color: Colors.grey[900], // Adjust the color to match the design
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            image,
            height: 32, // Adjust size to your preference
            width: 32,
          ),
        ),
      ),
    );
  }
}
