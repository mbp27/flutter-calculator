import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  const CalcButton({
    Key? key,
    required this.onPressed,
    this.color,
    required this.title,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Color? color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      fillColor: color ?? Theme.of(context).primaryColor,
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 22.0)),
    );
  }
}
