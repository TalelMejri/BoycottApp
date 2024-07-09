import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/entities/category.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/bloc/add_delete_update_category/adddeleteupdate_category_bloc.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/bloc/Product/product_bloc.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/pages/Product_pages.dart';
import 'package:com.talel.boycott/Core/Strings/constantes.dart';
import 'package:com.talel.boycott/Core/widgets/EmptyPage.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/widgets/category_add_update_widgets/SimpleDialog.dart';

class CategoryListWidget extends StatefulWidget {
  final List<Category> categories;

  const CategoryListWidget({Key? key, required this.categories})
      : super(key: key);

  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _confirmDelete(int id) async {
    final message = await showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (_) => SimpleDialogWidget(),
    );
    if (message == 'yes') {
      BlocProvider.of<AdddeleteupdateCategoryBloc>(context)
          .add(DeleteCategoryEvent(categoryId: id));
      _onRefresh();
    }
  }

  void _onRefresh() {
    BlocProvider.of<CategoryBloc>(context).add(GetAllCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return widget.categories.isEmpty
        ? const EmptyPage(message: "Category")
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              final category = widget.categories[index];
              return _buildCategoryItem(category);
            },
          );
  }

  Widget _buildCategoryItem(Category category) {
    return GestureDetector(
      onTap: () {
        context.read<ProductBloc>().add(
              GetAllProductEvent(
                id_categorie: category.id!,
              ),
            );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductPages(category: category),
          ),
        );
      },
      child: Card(
        shadowColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              width: 100,
              height: 100,
              imageUrl: BASE_URL_STORAGE + category.photo.path,
              placeholder: (_, __) => CircularProgressIndicator(),
              errorWidget: (_, __, ___) => Icon(Icons.error),
            ),
            // Text(
            //   category.name,
            //   style: const TextStyle(color: Colors.red, fontSize: 18),
            // ),
            // const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
  }) {
    return IconButton(onPressed: onPressed, icon: Icon(icon), color: color);
  }
}
