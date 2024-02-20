import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/Features/Product/domain/entities/Product.dart';

class RequestProductWidget extends StatefulWidget {
  final List<Product> product;

  const RequestProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<RequestProductWidget> createState() => _RequestProductWidgetState();
}

class _RequestProductWidgetState extends State<RequestProductWidget> {

    Future<void> _onRefresh(BuildContext context) async {
      //  BlocProvider.of<RequestBloc>(context).add(GetAllRequestCategoryEvent(status: 0));
      //  BlocProvider.of<CategoryBloc>(context).add(GetAllCategoryEvent());
       Navigator.of(context).pop();
    }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(children: [
        const Text("List Of Product Demanded"),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: widget.product.length,
            itemBuilder: (BuildContext context, int index) {
              final product = widget.product[index];
              return Card(
                child: ListTile(
                  leading:  Image.memory(
                          base64Decode(
                              (product.photo).split(',').last),
                          width: 100,
                          height: 100,
                        ),
                  title: Text(product.name), 
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Do You Want to Reject?"),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          //  BlocProvider.of<AcceptCategoryBlocBloc>(context)
                                          //      .add(RejectCategoryEvent(categoryId: product.id!));
                                          //       _onRefresh(context);
                                        },
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                        child: const Text("Yes"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                        child: const Text("No"),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                           showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Do You Want to Accept ?"),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                            // BlocProvider.of<AcceptCategoryBlocBloc>(context)
                                            //    .add(AcceptCategoryEvent(categoryId: category.id!));
                                            //      _onRefresh(context);
                                        },
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                        child: const Text("Yes"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                        child: const Text("No"),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.check_sharp, color: Colors.green,),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
