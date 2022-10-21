import 'package:flutter/material.dart';

class AddCarForm extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final String? Function(String?)? formValidator;
  final Color? prefixIconColor;
  final Color? suffixIconColor;

  const AddCarForm({
    Key? key,
    required this.hint,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.formValidator,
    required this.prefixIconColor,
    required this.suffixIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(5.0),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
          ]),
      child: TextFormField(
        textAlign: TextAlign.start,
        validator: formValidator,
        decoration: InputDecoration(
            fillColor: Colors.grey,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.blue),
            ),
            hintText: hint,
            prefixIcon: Icon(suffixIcon, color: prefixIconColor),
            suffixIcon: Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                prefixIcon,
                color: suffixIconColor,
              ),
            )),
      ),
    );
  }
}
