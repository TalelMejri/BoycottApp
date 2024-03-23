import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Features/Product/Presentation/bloc/Product/product_bloc.dart';
import 'package:mobile/Features/Product/Presentation/bloc/add_delete_update_product/adddeleteupdate_product_bloc.dart';
import 'package:mobile/Features/Product/Presentation/bloc/reject_accept_product/reject_accept_product_bloc.dart';
import 'package:mobile/Features/Product/domain/entities/Product.dart';

class RequestProductWidget extends StatefulWidget {
  final List<Product> product;
  final int id;

  const RequestProductWidget({
    Key? key,
    required this.product,
    required this.id,
  }) : super(key: key);

  @override
  State<RequestProductWidget> createState() => _RequestProductWidgetState();
}

class _RequestProductWidgetState extends State<RequestProductWidget> {

    Future<void> _onRefresh(BuildContext context) async {
       BlocProvider.of<RejectAcceptProductBloc>(context).add(GetAllRequestProductEvent(category_id: widget.id!));
       BlocProvider.of<ProductBloc>(context).add(GetAllProductEvent(id_categorie: widget.id));
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
                  leading: CachedNetworkImage(
                          width: 100,
                          height: 100,
                          imageUrl:
                              "http://10.0.2.2:8000"+product.photo.path,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
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
                                           BlocProvider.of<AdddeleteupdateProductBloc>(context)
                                               .add(RejectProductEvent(ProductId: product.id!));
                                                _onRefresh(context);
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
                                            BlocProvider.of<AdddeleteupdateProductBloc>(context)
                                               .add(AcceptProductEvent(ProductId: product.id!));
                                                _onRefresh(context);
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
