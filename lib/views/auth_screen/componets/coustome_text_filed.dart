import 'package:flutter/material.dart';
import 'package:recipes/constance.dart';

class CoustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String valdatorText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const CoustomTextField({
    required this.labelText,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.controller,
    required this.keyboardType,
    super.key,
    required this.valdatorText,
  });

  @override
  Widget build(BuildContext context) {
    Constans constants = Constans(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10.0 ,horizontal: 10), // Adjust vertical padding
            labelText: labelText,
            hintText: hintText,
            hintStyle: TextStyle(
              color: constants.black.withOpacity(0.5),
            ),
            suffixIcon: Icon(icon),
            labelStyle: TextStyle(
              color: constants.brown.withOpacity(0.7),
              fontSize: constants.width * 0.032,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: constants.brown),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: constants.brown),
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return valdatorText;
            }
            return null;
          },
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}
