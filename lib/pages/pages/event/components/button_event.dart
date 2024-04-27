import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonEvent extends StatelessWidget {
  const ButtonEvent({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.color,
    required this.bg,
    required this.shadow,
    required this.borderRadius,
    this.vertical,
  });
  final String text;
  final void Function() onTap;
  final IconData? icon;
  final Color? color;
  final Color bg;
  final Color shadow;
  final double borderRadius;
  final double? vertical;
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
          padding:  EdgeInsets.symmetric(
              vertical: vertical ?? 8, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: color ?? Colors.white,
                ),
              if (text != '')
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                        color: color ?? Colors.white,
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
