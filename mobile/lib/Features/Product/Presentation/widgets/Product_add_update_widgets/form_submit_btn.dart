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
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: isUpdateCategory ? Icon(Icons.edit) : Icon(Icons.add),
        label: Text(isUpdateCategory ? "Update" : "Add"));
  }
}