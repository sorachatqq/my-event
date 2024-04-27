import 'package:flutter/material.dart';

class TextAreaEvent extends StatelessWidget {
  const TextAreaEvent({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.obscureText,
    required this.hintText,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Color(0xffF0F0F0),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Color(0xff949494),
            blurRadius: 1.5,
            spreadRadius: -1,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: TextField(
        maxLines: 8,
        minLines: 1,
        controller: controller,
        enableSuggestions: false,
        enableInteractiveSelection: true,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        onSubmitted: (value) {
          if (value.length > 0) {
            // onTapReply();
          }
        },
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding:
                EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Color(0xff949494))),
      ),
    );
  }
}
