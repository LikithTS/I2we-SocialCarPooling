import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget otpCard(TextEditingController controller, Color borderColor,
        BuildContext context) =>
    Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 2,
      shadowColor: borderColor,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 45,
          width: 45,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            onSaved: (pin) {},
          ),
        ),
      ),
    );
