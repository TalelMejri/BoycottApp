import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  
  final void Function() onPressed;
  final bool isUpdateProduct;

  const FormSubmitBtn({
    Key? key,
    required this.onPressed,
    required this.isUpdateProduct,
  }) : super(key: key);

   Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: Text(isUpdateProduct ? "Update Product" : "Add Product"));
  }
}