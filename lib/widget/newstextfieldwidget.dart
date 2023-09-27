import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/globalcolors.dart';

class NewsTextFieldWidget extends StatelessWidget {
  const NewsTextFieldWidget({
    super.key,
    required this.emailController,
    required this.keyboardType,
    required this.validatorText,
    required this.hintText,
    required this.icon,
    required this.obscureText,
  });

  final TextEditingController emailController;
  final TextInputType keyboardType;
  final String validatorText;
  final String hintText;
  final IconData icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: emailController,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              color: GlobalColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w700)),
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(icon),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 0))),
    );
  }
}