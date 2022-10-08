import 'package:flutter/material.dart';

class LoginTextForm extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;
  final IconData suffixIcon;

  const LoginTextForm(
      {Key? key,
      required this.hint,
      required this.prefixIcon,
      required this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
          ]),
      child: TextFormField(
        textAlign: TextAlign.start,
        decoration: InputDecoration(
            fillColor: Colors.grey,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.blue),
            ),
            hintText: hint,
            suffixIcon: Icon(suffixIcon, color: Colors.green),
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.grey,
            )),
      ),
    );
  }
}
