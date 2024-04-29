import 'package:flutter/material.dart';

class SelectEvent extends StatelessWidget {
  const SelectEvent({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
  });

  final String hintText;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffF0F0F0),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Color(0xff949494),
            blurRadius: 1.5,
            spreadRadius: -1,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 40,
            color: Color(0xff949494),
          ),
          items: items.map((String value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          hint: Text(
            hintText,
            style: const TextStyle(fontSize: 16, color: Color(0xff949494)),
          ),
          onChanged: onChanged,
          value: value,
        )
      ),
      // child: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text(
      //         hintText,
      //         style: const TextStyle(fontSize: 16, color: Color(0xff949494)),
      //       ),
      //       const Icon(
      //         Icons.arrow_drop_down,
      //         size: 40,
      //         color: Color(0xff949494),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
