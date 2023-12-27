import 'package:flutter/material.dart';
import 'package:mobile/Core/widgets/EmptyPage.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';
import 'dart:convert';

class CategoryListWidget extends StatelessWidget {
  final List<Category> category;
  const CategoryListWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  category!.length==0 ? EmptyPage() : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: category.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
               Image.memory(
                  width: 200,
                  height: 100,
                  base64Decode((category[index].photo).split(',').last),
                  ),
                  SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Name :",style: TextStyle(color: Colors.red),),
                    Text(category[index].name),
                  ],
                ),
              ],
            ),
          );
        },
      );
  }
}