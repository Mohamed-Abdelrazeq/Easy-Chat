import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  MyTextField({@required this.hint,@required this.controller});

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration:  InputDecoration(
        hintText: hint,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
      ),
    );
  }
}