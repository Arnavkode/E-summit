import 'package:flutter/material.dart';

import 'Datas.dart';

class PasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;

  const PasswordField({
    super.key,
    required this.hintText,
    this.controller,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  String? _errorText;

  // Password validation function
  String? _validatePassword(String value) {
    if (value.length < 6 || value.length > 12) {
      return "Password must be 6-12 characters";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "At least one uppercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "At least one number";
    }
    
    return null; // No errors
  }

  @override
  Widget build(BuildContext context) {
    return Card(
    
      color: Colors.transparent,
  child: IntrinsicHeight(  // Auto-adjusts height based on content
    child: Padding(
      padding: EdgeInsets.only(right: 0.075*ScreenWidth(context)),
      child: Column(
        children: [
          TextField(
            
            controller: widget.controller,
            obscureText: _obscureText,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                _errorText = _validatePassword(value);
              });
            },
            decoration: InputDecoration(
              
              hintText: widget.hintText,
              filled: true,
              fillColor: Colors.white,
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
              errorText: _errorText,
              
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
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
