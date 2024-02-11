import 'package:flutter/material.dart';

class MyForm extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType textInputType;
  final String? Function(String?)? validator;

  const MyForm({
    super.key,
    required this.controller,
    required this.label,
    this.textInputType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text, // textInputType
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Color(0xFFDADADA),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Color(0xff014f9f),
              width: 1,
            ),
          ),
          hintText: 'Please Enter your $label',
          hintStyle: const TextStyle(
            color: Color(0xff8391A1),
          ),
          filled: true,
          fillColor: const Color(0xFFF7F8F9),
        ),
      ),
    );
  }
}
