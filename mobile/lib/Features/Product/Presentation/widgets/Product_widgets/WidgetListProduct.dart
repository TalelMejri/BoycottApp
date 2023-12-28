import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Core/widgets/EmptyPage.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';
import 'package:mobile/Features/Product/Presentation/bloc/add_delete_update_product/adddeleteupdate_product_bloc.dart';
import 'package:mobile/Features/Product/Presentation/pages/add_update_product.dart';
import 'package:mobile/Features/Product/Presentation/widgets/Product_add_update_widgets/SimpleDialog.dart';
import 'package:mobile/Features/Product/Presentation/widgets/Product_widgets/bottomSheetWidget.dart';
import 'dart:convert';
import 'package:mobile/Features/Product/domain/entities/Product.dart';

class WidgetListProduct extends StatefulWidget {
  final Category category;
  final List<Product> product;
  const WidgetListProduct({
    Key? key,
    required this.category,
    required this.product,
  }) : super(key: key);

  @override
  State<WidgetListProduct> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<WidgetListProduct> {

   Future<void> ConfirmDelete(id) async { 
     String ? message=await showDialog(
      barrierDismissible: false,
      context: context,
       builder:(BuildContext context){
          return SimpleDialogWidget();
        });
        if (message!=null){
          if(message=="yes"){
            BlocProvider.of<AdddeleteupdateProductBloc>(context)
            .add(DeleteProductEvent(ProductId: id));
          }
        }
   }

  Future<void> AlertBottomSheet(Product product)async{
    await showModalBottomSheet(
      context: context, 
      builder:(BuildContext context){
        return  boottomWidget(product:product);
    });
    }

  @override
  Widget build(BuildContext context) {
    return widget.product == null || widget.product.isEmpty
        ? const EmptyPage(message: "Product",)
        : ListView.builder(itemCount: widget.product.length,itemBuilder: (context,index) {
               final item=widget.product[index];
               return Dismissible(
                    key: Key(item.name),
                      background:  Container(
                               color: Colors.red,
                                child:const Icon(Icons.delete,size: 40,color: Colors.white,),
                      ),
                      onDismissed: (direction){
                                setState(() {
                                  ConfirmDelete(item.id);
                                  widget.product.remove(item);
                                });
                                
                        },
                    child: Card(
                         child: ListTile(
                         title: Text(item.name),
                         subtitle: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal,
                            ),
                           onPressed: (){
                                AlertBottomSheet(item);
                           },
                           child: const Text("Why ?"),
                         ),
                          trailing: IconButton(icon: Icon(Icons.edit),onPressed: (){
                            Navigator.push(
                            context,MaterialPageRoute(builder: (context)=>ProductAddUpdatePage(
                                category: widget.category,
                                product: item,
                                isUpdateProduct: true
                               )
                              )
                            );
                          },),
                          leading:Container(
                                  width: 50, 
                                  height: 50, 
                                  decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(25), 
                                     boxShadow:[
                                       BoxShadow(
                                          color: const Color.fromARGB(255, 161, 142, 142),
                                      )
                                     ]
                                  ),
                                  child: Image.memory(
                                          base64Decode(
                                              (item.photo).split(',').last),
                                          fit: BoxFit.cover,
                                    ),
                                )
                                ),
                            ),
                      );
           });
      }
}

