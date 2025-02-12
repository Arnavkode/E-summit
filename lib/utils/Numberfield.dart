import 'package:flutter/material.dart';

import 'Datas.dart';

class NumberField extends StatefulWidget {
    final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;

  const NumberField({super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.number,
    this.prefixIcon,});

  @override
  State<NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {

  String? error;
  String? validatePhone(String value){

    if(value.length > 10){
      return "Invalid number";
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      
      color: Colors.transparent,
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.only(right: 0.075*ScreenWidth(context)),
          child: Column(
            // height: 50,
            // width: 0.8*ScreenWidth(context),
            children: [
              TextField(
                onChanged: (value){
                  setState(() {
                    error = validatePhone(value);
                  });
                } ,
                controller: widget.controller,
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
                decoration: InputDecoration(
                  errorText: error,
                  hintText: widget.hintText,
                  filled: true,
                  fillColor: Colors.white, // No extra background
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: Colors.white) : null,
                ),
                style: const TextStyle(color: Colors.black, fontFamily: "Inter-r", fontSize: 16),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}