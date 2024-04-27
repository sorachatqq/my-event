import 'package:flutter/material.dart';

class SelectLogin extends StatelessWidget {
  const SelectLogin({
    super.key,
    required this.hintText,
  });

  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hintText,
              style: TextStyle(fontSize: 16, color: Color(0xff949494)),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 40,
              color: Color(0xff949494),
            )
          ],
        ),
      ),
    );
  }
}
