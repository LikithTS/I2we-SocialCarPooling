import 'package:flutter/material.dart';

class LoginTextForm extends StatelessWidget {
  final String hint;
  final String lableText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final TextEditingController editingController;
  final String? Function(String?)? formValidator;

  const LoginTextForm(
      {Key? key,
      required this.hint,
      required this.lableText,
      required this.prefixIcon,
      required this.suffixIcon,
      required this.editingController,
      required this.formValidator})
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
        validator: formValidator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            fillColor: Colors.grey,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.blue),
            ),
            hintText: hint,
            labelText: lableText,
            suffixIcon: Icon(suffixIcon, color: Colors.green),
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.grey,
            )),
      ),
    );
  }
}
