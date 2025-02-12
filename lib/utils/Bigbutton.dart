import 'package:e_summit25/utils/Datas.dart';
import 'package:flutter/material.dart';

class Bigbutton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;
  final double borderRadius;
  final double fontSize;

  const Bigbutton({
    super.key,
    required this.label,
    required this.onTap,
    this.color = Colors.blue,
    this.borderRadius = 12.0,
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.6* ScreenWidth(context),
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
