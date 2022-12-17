import 'package:flutter/material.dart';

class HomeTextIconForm extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;

  const HomeTextIconForm(
      {Key? key, required this.hint, required this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
          ]),
      child: TextFormField(
        textAlign: TextAlign.start,
        decoration: InputDecoration(
            fillColor: Colors.grey,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent),
            ),
            hintText: hint,
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.grey,
            )),
      ),
    );
  }
}
