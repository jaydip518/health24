import 'package:flutter/material.dart';

class Comman_tax extends StatelessWidget {
  final hint;
  final sufix;
  final formate;
  final bool obscur;
  final VoidCallback ontap;
  final String? Function(String?)? validator;
  final void Function(String)? onchage;
  final contro;
  final keybor;
  final contentPadding;
  const Comman_tax({
    Key? key,
    this.hint,
    this.validator,
    this.onchage,
    this.contro,
    this.sufix,
    required this.ontap,
    required this.obscur,
    this.keybor,
    this.formate, this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: ontap,
      keyboardType: keybor,
      obscureText: obscur,
      validator: validator,
      onChanged: onchage,
      controller: contro,
      inputFormatters: formate,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: contentPadding,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black),
        fillColor: Colors.grey.shade100,
        filled: true,
        suffixIcon: sufix,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.teal)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff555555)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
