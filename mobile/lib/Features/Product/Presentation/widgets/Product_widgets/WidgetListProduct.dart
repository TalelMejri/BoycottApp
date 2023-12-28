import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Core/widgets/EmptyPage.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/add_delete_update_category/adddeleteupdate_category_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/widgets/category_add_update_widgets/SimpleDialog.dart';
import 'dart:convert';

import 'package:mobile/Features/Product/domain/entities/Product.dart';

class WidgetListProduct extends StatefulWidget {

  final List<Product> product;
  const WidgetListProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<WidgetListProduct> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<WidgetListProduct> {

   Future<void> ConfirmDelete(id)async{
     String ? message=await showDialog(
      barrierDismissible: false,
      context: context,
       builder:(BuildContext context){
          return SimpleDialogWidget();
        });
        if (message!=null){
          if(message=="yes"){
            BlocProvider.of<AdddeleteupdateCategoryBloc>(context)
            .add(DeleteCategoryEvent(categoryId: id));
            _onRefresh(context);
          }
        }
   }

    Future<void> _onRefresh(BuildContext context) async{
      BlocProvider.of<CategoryBloc>(context).add(RefreshCategoryEvent());
    }

    @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.product == null || widget.product.isEmpty
        ? const EmptyPage()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: widget.product.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  children: [
                    Image.memory(
                      base64Decode((widget.product[index].photo).split(',').last),
                      width: 200,
                      height: 100,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text("Name:", style: TextStyle(color: Colors.red)),
                        Text(widget.product[index].name),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed:()async { await ConfirmDelete(widget.product[index].id);},
                          icon: const Icon(Icons.delete),
                          label: const Text("Delete"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red,
                            ),
                          ),
                        ),
                        const SizedBox(width: 2,),
                        ElevatedButton.icon(
                          onPressed: () {
                            
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text("Edit"),
                           style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.yellow,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
      }
}

