import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String message;
  const EmptyPage({Key? key,required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: SizedBox(
          child:Text("No $message Yet")
        ),
      ),
    );
  }
}