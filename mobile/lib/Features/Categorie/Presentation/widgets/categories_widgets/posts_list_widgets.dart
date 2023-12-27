import 'package:flutter/material.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';

class CatgeoryListWidget extends StatelessWidget {
  final List<Category> category;
  const CatgeoryListWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: category.length,
      itemBuilder: (context, index) {
        return Dismissible(key:Key(category[index].id.toString()),
         background:  Container(
            color: Colors.cyan,
                    child:const Icon(Icons.delete,size: 40,color: Colors.white,),
          ),
            onDismissed: (direction){
             ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${category[index].name} Deleted"))
                );
             },
          child: 
             ListTile(
          leading: Text(category[index].id.toString()),
          title: Text(
            category[index].name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            category[index].name,
            style: const TextStyle(fontSize: 16),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: () { },
        )
       );
        
      },
      separatorBuilder: (context, index) => const Divider(thickness: 1),
    );
  }
}