import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile/Features/Auth/data/datasource/user_local_data_source.dart';
import 'package:mobile/Features/Auth/data/model/UserModelLogin.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/add_delete_update_category/adddeleteupdate_category_bloc.dart';
import 'package:mobile/Features/Product/Presentation/bloc/Product/product_bloc.dart';
import 'package:mobile/Features/Product/Presentation/pages/Product_pages.dart';
import 'package:mobile/Core/Strings/constantes.dart';
import 'package:mobile/Core/widgets/EmptyPage.dart';
import 'package:mobile/Features/Categorie/Presentation/pages/add_update_category.dart';
import 'package:mobile/Features/Categorie/Presentation/widgets/category_add_update_widgets/SimpleDialog.dart';
import 'package:mobile/injection_container.dart';

class CategoryListWidget extends StatefulWidget {
  final List<Category> categories;

  const CategoryListWidget({Key? key, required this.categories})
      : super(key: key);

  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  final UserLocalDataSource _userLocalDataSource =
      sl.get<UserLocalDataSource>();
   bool _isAuthenticated=false;
  UserModelLogin? user = null;
  @override
  void initState() {
    getAuth();
    super.initState();
  }

  void getAuth() async {
    var res = await _userLocalDataSource.getCachedUser() != null ? true : false;
    if (res) {
      user = await _userLocalDataSource.getCachedUser();
    }
    setState(() {
      _isAuthenticated = res;
    });
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
        child: Column(
          children: [
            CachedNetworkImage(
              width: 100,
              height: 100,
              imageUrl: BASE_URL_STORAGE + category.photo.path,
              placeholder: (_, __) => CircularProgressIndicator(),
              errorWidget: (_, __, ___) => Icon(Icons.error),
            ),
            Text(
              category.name,
              style: const TextStyle(color: Colors.red,fontSize: 18),
            ),
            const SizedBox(height: 12),
            Visibility(
              visible: (_isAuthenticated &&
                      user?.id.toString() == category.user_id.toString()) ||
                  (user?.role == "1"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    onPressed: () => _confirmDelete(category.id!),
                    icon: Icons.delete,
                    color: Colors.red,
                    borderRadius: 4.0
                  ),
                  const SizedBox(width: 2),
                  _buildActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryAddUpdatePage(
                            isUpdateCategory: true,
                            category: category,
                          ),
                        ),
                      );
                    },
                    icon: Icons.edit,
                    color: Colors.yellow,
                    borderRadius: 4.0
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

Widget _buildActionButton({
  required VoidCallback onPressed,
  required IconData icon,
  required Color color,
  required double borderRadius,
}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      color: Colors.white, // Change the icon color if needed
    ),
  );
}
}
