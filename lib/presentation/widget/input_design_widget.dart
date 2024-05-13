import 'package:flutter/material.dart';

class InputDesign extends StatelessWidget {
  final TextInputType inputType;
  final String hintText;
  final TextEditingController controller;

  const InputDesign({
    Key? key,
    required this.hintText,
    required this.inputType,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintStyle: const TextStyle(fontSize: 13),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff959595),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff959595),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff959595),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        contentPadding: const EdgeInsets.all(14),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(color: Color(0xff959595)),
        ),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}