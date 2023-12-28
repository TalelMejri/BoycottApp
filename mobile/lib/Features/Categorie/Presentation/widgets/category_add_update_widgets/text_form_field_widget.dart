import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
    final Function onChanged;
    final String hintText;
    final IconData icon;
    final String labelText;
    final TextInputType keyboardType;
    final String? Function(String?)? validation;
    final String initialValue;

  const TextFormFieldWidget(
      {required this.onChanged,
      required this.hintText,
      required this.icon,
      required this.keyboardType,
      required this.labelText,
      required this.validation,
      required this.initialValue,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: TextFormField(
          initialValue: initialValue,
          validator: validation,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
             onChanged(value);
          },
           decoration: InputDecoration(
               border: OutlineInputBorder(borderRadius:BorderRadius.circular(14) ),
               hintText: "$hintText",
               label:  Text("$labelText"),
           ),
        ));
  }
}