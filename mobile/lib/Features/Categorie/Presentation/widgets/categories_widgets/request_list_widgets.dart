import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Core/Strings/constantes.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/RequestCategory/request_category_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/accept_reject_category/accept_category_bloc_bloc.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';

class RequestCategoryListWidget extends StatefulWidget {
  final List<Category> category;

  const RequestCategoryListWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<RequestCategoryListWidget> createState() => _RequestCategoryListWidgetState();
}

class _RequestCategoryListWidgetState extends State<RequestCategoryListWidget> {

    Future<void> _onRefresh(BuildContext context) async {
       BlocProvider.of<RequestBloc>(context).add(GetAllRequestCategoryEvent(status: 0));
       BlocProvider.of<CategoryBloc>(context).add(GetAllCategoryEvent());
       Navigator.of(context).pop();
    }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(children: [
        const Text("List of categories is requested"),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: widget.category.length,
            itemBuilder: (BuildContext context, int index) {
              final category = widget.category[index];
              return Card(
                child: ListTile(
                  leading:CachedNetworkImage(
                          width: 100,
                          height: 100,
                          imageUrl:
                              BASE_URL_STORAGE+""+widget.category[index].photo.path,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                  title: Text(category.name), 
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Would you like to reject ?"),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                           BlocProvider.of<AcceptCategoryBlocBloc>(context)
                                               .add(RejectCategoryEvent(categoryId: category.id!));
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
                                title: const Text("Would you like to accept ?"),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                            BlocProvider.of<AcceptCategoryBlocBloc>(context)
                                               .add(AcceptCategoryEvent(categoryId: category.id!));
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
                        icon: const Icon(Icons.check_sharp, color: Colors.green,),
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
