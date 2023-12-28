import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  
  final void Function() onPressed;
  final bool isUpdateProduct;

  const FormSubmitBtn({
    Key? key,
    required this.onPressed,
    required this.isUpdateProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: isUpdateProduct ? Icon(Icons.edit) : Icon(Icons.add),
        label: Text(isUpdateProduct ? "Update" : "Add"));
  }
}