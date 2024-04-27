import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonProfile extends StatelessWidget {
  const ButtonProfile({
    super.key,
    required this.text,
    required this.onTap,
    required this.bg,
    required this.shadow,
    required this.borderRadius,
  });
  final String text;
  final void Function() onTap;
  final Color bg;
  final Color shadow;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: [
            BoxShadow(
              color: shadow,
              blurRadius: 1.5,
              spreadRadius: 0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
