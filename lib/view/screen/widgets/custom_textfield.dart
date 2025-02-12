import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType inputType;
  final int? maxlenth;
  final bool? readOnly;
  final int? maxLine;

  CustomTextField({
    required this.label,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    this.inputType = TextInputType.text,
    this.maxlenth,
    this.readOnly,
     this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5),
        TextField(
          maxLines: maxLine,
          maxLength: maxlenth,
          controller: controller,
          obscureText: isPassword,
          keyboardType: inputType,
          readOnly: readOnly ?? false,
          decoration: InputDecoration(
            counterText: "",
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2.0,
              ),
            ),

          ),
        ),
      ],
    );
  }
}
