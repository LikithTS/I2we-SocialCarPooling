import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginTextForm extends StatefulWidget {
  final String hint;
  final String lableText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final TextEditingController editingController;
  final String? Function(String?)? formValidator;
  bool isPasswordField;
  final bool isNumber;

  LoginTextForm({Key? key,
    required this.hint,
    required this.lableText,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.editingController,
    required this.formValidator,
    required this.isPasswordField,
    required this.isNumber})
      : super(key: key);

  @override
  InputFieldState createState() => InputFieldState();

}

class InputFieldState extends State<LoginTextForm> {

  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {

    FocusNode focusNode = FocusNode();

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
          ]),
      child: TextFormField(
        keyboardType: checkForInputType(widget.isNumber),
        obscureText:  checkForObsureText(widget.isNumber),
        inputFormatters: [
          LengthLimitingTextInputFormatter(10)
        ],
        textAlign: TextAlign.start,
        validator: widget.formValidator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            fillColor: Colors.grey,
            counterText: "",
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.blue),
            ),
            hintText: widget.hint,
            labelText: widget.lableText,
            suffixIcon: IconButton(
              iconSize: 30,
              icon: Icon(widget.suffixIcon),
              color: Colors.green,
              onPressed: () {
                handlePasswordVisibleText(widget.isNumber);
              },
            ),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: Colors.grey,
            )),
      ),
    );
  }

  checkForInputType(bool isNumber) {
    if(isNumber) {
      return TextInputType.number;
    } else {
      TextInputType.text;
    }
  }

  checkForObsureText(bool isNumber) {
    if(!isNumber) {
      return !_passwordVisible;
    } else {
      return _passwordVisible;
    }
  }

  void handlePasswordVisibleText(bool number) {
    if(!number) {
      setState(() {
        _passwordVisible = !_passwordVisible;
        log("Password visible $_passwordVisible");
      });
    }
  }
}
