import 'package:flutter/material.dart';

class ButtonCSGAME extends StatefulWidget {
  final String text;
  final VoidCallback onClicked;
  const ButtonCSGAME({Key? key, required this.text, required this.onClicked}) : super(key: key);
  @override
  State<ButtonCSGAME> createState() => _ButtonCSGAMEState();
}

class _ButtonCSGAMEState extends State<ButtonCSGAME> {

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50),
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    onPressed: widget.onClicked,
    child: Text(
      widget.text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}