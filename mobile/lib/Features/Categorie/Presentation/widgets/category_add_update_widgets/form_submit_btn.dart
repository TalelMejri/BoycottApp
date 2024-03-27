import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdateCategory;

  const FormSubmitBtn({
    Key? key,
    required this.onPressed,
    required this.isUpdateCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: Text(isUpdateCategory ? "Update Category" : "Add Category"));
  }
}