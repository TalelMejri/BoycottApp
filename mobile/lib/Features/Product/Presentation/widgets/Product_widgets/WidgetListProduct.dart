import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Core/Strings/constantes.dart';
import 'package:mobile/Core/widgets/EmptyPage.dart';
import 'package:mobile/Features/Auth/data/datasource/user_local_data_source.dart';
import 'package:mobile/Features/Auth/data/model/UserModelLogin.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';
import 'package:mobile/Features/Product/Presentation/bloc/add_delete_update_product/adddeleteupdate_product_bloc.dart';
import 'package:mobile/Features/Product/Presentation/pages/add_update_product.dart';
import 'package:mobile/Features/Product/Presentation/widgets/Product_add_update_widgets/SimpleDialog.dart';
import 'package:mobile/Features/Product/Presentation/widgets/Product_widgets/bottomSheetWidget.dart';
import 'package:mobile/Features/Product/domain/entities/Product.dart';
import 'package:mobile/injection_container.dart';

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

  int _selectIndex = 0;
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
        BlocProvider.of<AdddeleteupdateProductBloc>(context)
            .add(DeleteProductEvent(ProductId: id));
      }
    }
  }

  Future<void> AlertBottomSheet(Product product) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return boottomWidget(product: product);
        });
  }

  @override
  Widget build(BuildContext context) {
    return widget.product == null || widget.product.isEmpty
        ? const EmptyPage(
            message: "Product",
          )
        : ListView.builder(
            itemCount: widget.product.length,
            itemBuilder: (context, index) {
              final item = widget.product[index];
              return Dismissible(
                key: Key(item.name),
                background: Container(
                  color: Colors.red,
                  child:
                      const Icon(Icons.delete, size: 40, color: Colors.white),
                ),
                onDismissed: (direction) {
                  setState(() {
                  if ((auth &&
                          user?.id.toString() == item.user_id.toString()) ||
                      (user?.role == "1")) {
                    ConfirmDelete(item.id);
                    widget.product.remove(item);
                  } 
                });
                },
                child: Card(
                  child: ListTile(
                      title: Text(item.name),
                      subtitle: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                        ),
                        onPressed: () {
                          AlertBottomSheet(item);
                        },
                        child: const Text("Why ?"),
                      ),
                      trailing: Visibility(
                          visible: (auth &&
                                  user?.id.toString() ==
                                      item.user_id.toString()) ||
                              (user?.role == "1"),
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductAddUpdatePage(
                                              category: widget.category,
                                              product: item,
                                              isUpdateProduct: true)));
                            },
                          )),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                               BoxShadow(
                                color:  Color.fromARGB(255, 161, 142, 142),
                              )
                            ]),
                        child: CachedNetworkImage(
                          width: 100,
                          height: 100,
                          imageUrl:
                              BASE_URL_STORAGE+widget.product[index].photo.path,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                             const Icon(Icons.error),
                        ),
                      )),
                ),
              );
            });
  }
}
