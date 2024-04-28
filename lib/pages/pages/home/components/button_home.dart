import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonHome extends StatelessWidget {
  const ButtonHome({
    super.key,
    required this.text,
    required this.onTap,
    required this.bg,
    required this.shadow,
    required this.borderRadius,
    required this.icons,
    this.fontSize,
    this.isLoading,
  });
  final String text;
  final void Function() onTap;
  final Color bg;
  final Color shadow;
  final double borderRadius;
  final IconData icons;
  final double? fontSize;
  final bool? isLoading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading == true ? () {} : onTap,
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
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: isLoading == true ? const Text("Loading", 
            style: TextStyle(
              color: Colors.white,
            )
          ) : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icons,
                color: Colors.white,
                size: 18,
              ),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize ?? 12,
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
