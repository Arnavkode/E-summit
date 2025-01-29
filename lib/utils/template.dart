import 'package:flutter/material.dart';

double ScreenWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

double ScreenHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}

TextStyle basic() {
  return TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontFamily: 'Inter',
  );
}
