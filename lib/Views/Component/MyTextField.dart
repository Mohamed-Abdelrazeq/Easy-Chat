import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {

  MyTextField({@required this.hint,@required this.controller});

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp('[ ]')),
      ],
      controller: controller,
      decoration:  InputDecoration(
        hintText: hint,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 1.0),
        ),
      ),
    );
  }
}