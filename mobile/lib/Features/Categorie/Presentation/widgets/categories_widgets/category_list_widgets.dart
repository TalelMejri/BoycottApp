
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Core/widgets/EmptyPage.dart';
import 'package:mobile/Features/Auth/data/datasource/user_local_data_source.dart';
import 'package:mobile/Features/Auth/data/model/UserModelLogin.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/add_delete_update_category/adddeleteupdate_category_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/pages/add_update_category.dart';
import 'package:mobile/Features/Categorie/Presentation/widgets/category_add_update_widgets/SimpleDialog.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';
import 'package:mobile/Features/Product/Presentation/bloc/Product/product_bloc.dart';

import 'package:mobile/Features/Product/Presentation/pages/Product_pages.dart';
import 'package:mobile/injection_container.dart';

class CategoryListWidget extends StatefulWidget {
  final List<Category> category;
  const CategoryListWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  final UserLocalDataSource userLocalDataSource = sl.get<UserLocalDataSource>();

  @override
  void initState() {
    getAuth();
    super.initState();
  }

  UserModelLogin? user = null;

  void getAuth() async {
    var res = await userLocalDataSource.getCachedUser() != null ? true : false;
    if (res) {
      user = await userLocalDataSource.getCachedUser();
    }
    setState(() {
      auth = res;
    });
  }

  bool auth = false;

  Future<void> ConfirmDelete(id) async {
    String? message = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialogWidget();
        });
    if (message != null) {
      if (message == "yes") {
        BlocProvider.of<AdddeleteupdateCategoryBloc>(context)
            .add(DeleteCategoryEvent(categoryId: id));
        _onRefresh(context);
      }
    }
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<CategoryBloc>(context).add(GetAllCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return widget.category == null || widget.category.isEmpty
        ? const EmptyPage(message: "Category")
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: widget.category.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    context.read<ProductBloc>().add(
                          GetAllProductEvent(
                            id_categorie: widget.category[index].id!,
                          ),
                        );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPages(
                          category: widget.category[index],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          width: 100,
                          height: 100,
                          imageUrl:
                              "http://10.0.2.2:8000"+widget.category[index].photo.path,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Name:", style: TextStyle(color: Colors.red)),
                            Text(widget.category[index].name),
                          ],
                        ),
                        SizedBox(height: 12),
                        Visibility(
                            visible: (auth &&
                                    user?.id.toString() ==
                                        widget.category[index].user_id
                                            .toString()) ||
                                (user?.role == 1),
                            child: Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    await ConfirmDelete(
                                        widget.category[index].id);
                                  },
                                  icon: const Icon(Icons.delete),
                                  label: const Text("Delete"),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.red,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryAddUpdatePage(
                                                    isUpdateCategory: true,
                                                    category: widget
                                                        .category[index])));
                                  },
                                  icon: const Icon(Icons.edit),
                                  label: const Text("Edit"),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.yellow,
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ));
            },
          );
  }
}
