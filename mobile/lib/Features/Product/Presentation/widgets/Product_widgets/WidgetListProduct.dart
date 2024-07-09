import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.talel.boycott/Core/Strings/constantes.dart';
import 'package:com.talel.boycott/Core/widgets/EmptyPage.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/entities/category.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/bloc/add_delete_update_product/adddeleteupdate_product_bloc.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/pages/add_update_product.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/widgets/Product_add_update_widgets/SimpleDialog.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/widgets/Product_widgets/bottomSheetWidget.dart';
import 'package:com.talel.boycott/Features/Product/domain/entities/Product.dart';
import 'package:com.talel.boycott/injection_container.dart';

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
  @override
  void initState() {
    super.initState();
  }

  int _selectIndex = 0;
  bool auth = false;

  Future<void> ConfirmDelete(id) async {
    final message = await showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (_) => SimpleDialogWidget(),
    );
    if (message == "yes") {
      BlocProvider.of<AdddeleteupdateProductBloc>(context)
          .add(DeleteProductEvent(ProductId: id));
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
            message: "Items",
          )
        : ListView.builder(
            itemCount: widget.product.length,
            itemBuilder: (context, index) {
              final item = widget.product[index];
              return Card(
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
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 161, 142, 142),
                        ),
                      ],
                    ),
                    child: CachedNetworkImage(
                      width: 100,
                      height: 100,
                      imageUrl:
                          BASE_URL_STORAGE + widget.product[index].photo.path,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
