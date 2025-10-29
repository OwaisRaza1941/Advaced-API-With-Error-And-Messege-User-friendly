import 'package:flutter/material.dart';

SizedBox textFields({
  required String hintText,
  required TextEditingController controller,
}) {
  return SizedBox(
    width: 320,
    child: TextField(
      controller: controller,
      cursorColor: Colors.blue,
      style: TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    ),
  );
}
