import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Core/utils/snack_bar_message.dart';
import 'package:mobile/Core/widgets/Loading_widget.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/add_delete_update_category/adddeleteupdate_category_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/pages/Category_pages.dart';
import 'package:mobile/Features/Categorie/Presentation/widgets/category_add_update_widgets/form_widget.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';

class CategoryAddUpdatePage extends StatelessWidget {
  final Category? category;
  final bool isUpdateCategory;
  const CategoryAddUpdatePage({Key? key, this.category, required this.isUpdateCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:isUpdateCategory ? _buildAppbar() : null,
      body: _buildBody(),
    );
  }
  
  AppBar _buildAppbar() {
    return AppBar(title: const Text("Category"));
  }

  Widget _buildBody() {
    return
          BlocConsumer<AdddeleteupdateCategoryBloc, AdddeleteupdateCategoryState>(
            listener: (context, state) {
              if (state is MessageAddUpdateDeleteCategoryState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                  _onRefresh(context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => CategoriePages()),
                    (route) => false);
              } else if (state is ErrorAddUpdateDeleteCategoryState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
             if (state is LoadingAddUpdateDeleteCategoryState) {
                return LoadingWidget();
             }
              return FormWidget(
                  isUpdateCategory: isUpdateCategory, category: isUpdateCategory ? category : null);
            },
          );
  }

    Future<void> _onRefresh(BuildContext context) async{
     BlocProvider.of<CategoryBloc>(context).add(GetAllCategoryEvent());
  }
}