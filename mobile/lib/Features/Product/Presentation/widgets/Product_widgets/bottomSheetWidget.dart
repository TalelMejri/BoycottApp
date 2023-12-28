import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/Features/Product/domain/entities/Product.dart';


class boottomWidget extends StatelessWidget{
   final Product product;

   boottomWidget({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Text("Why Should Bycott "+product.name,textAlign: TextAlign.center,style:
               const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
               ),),
               const SizedBox(height: 20),
            Image.memory(
                    base64Decode(
                    (product.photo).split(',').last),
                      width: 100,
                      height: 100,
            ),
            const SizedBox(height: 40),
            Text(product.description,textAlign: TextAlign.center,style:
               const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
               ),),
               const SizedBox(height: 20,),
        ],
        ),
      ),
    );
  }
}