import 'package:flutter/material.dart';
import 'package:mobile/Core/widgets/Loading_widget.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/widgets/categories_widgets/MessageDisplayWidget.dart';
import 'package:mobile/Features/Categorie/Presentation/widgets/categories_widgets/posts_list_widgets.dart';

class CategoriePages extends StatelessWidget {
  const CategoriePages({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppBar() => AppBar(title: const Text('Category'));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
        if (state is LoadingCategoryState) {
          return const LoadingWidget();
        } else if (state is LoadedCategory) {
            return RefreshIndicator(
                child: CatgeoryListWidget(category: state.categorys), 
                onRefresh: ()=>_onRefresh(context),
              );
        } else if (state is ErrorCategoryState) {
          return MessageDisplayWidget(message:state.message);
        } else {
          return const LoadingWidget();
        }
      }),
    );
  }

    Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) => const PostAddUpdatePage(
        //               isUpdatePost: false,
        //             )));
      },
      child: const Icon(Icons.add),
    );
  }

  Future<void> _onRefresh(BuildContext context) async{
     BlocProvider.of<CategoryBloc>(context).add(RefreshCategoryEvent());
  }
}