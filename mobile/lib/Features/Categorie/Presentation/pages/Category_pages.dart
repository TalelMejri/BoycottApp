import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:com.talel.boycott/Core/widgets/LandingPage.dart';
import 'package:com.talel.boycott/Core/widgets/Loading_widget.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/pages/add_update_category.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/widgets/categories_widgets/MessageDisplayWidget.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/widgets/categories_widgets/category_list_widgets.dart';

class CategoriePages extends StatefulWidget {
  const CategoriePages({super.key});

  @override
  State<CategoriePages> createState() => _CategoriePagesState();
}

class _CategoriePagesState extends State<CategoriePages> {
  @override
  void initState() {
    /* BlocProvider.of<CategoryBloc>(context)
            .add(GetAllRequestEvent(status: 0));*/
    super.initState();
  }

  int _selectIndex = 0;

  void changeSelectedINdex(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectIndex != 2 ? _buildAppBar() : null,
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: _selectIndex == 0
            ? const Text('Category')
            : const Text('Add Category'),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LandingPage()));
            },
            icon: const Icon(Icons.arrow_back)),
      );

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child:
          BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
        if (state is LoadingCategoryState) {
          return const LoadingWidget();
        } else if (state is LoadedCategory) {
          return RefreshIndicator(
            child: _selectIndex == 0
                ? CategoryListWidget(categories: state.categorys)
                : _selectIndex == 1
                    ? const CategoryAddUpdatePage(isUpdateCategory: false)
                    : Container(),
            onRefresh: () => _onRefresh(context),
          );
        } else if (state is ErrorCategoryState) {
          return MessageDisplayWidget(message: state.message);
        } else {
          return const LoadingWidget();
        }
      }),
    );
  }

  Widget _buildBottomNavigationBar() {
    return CurvedNavigationBar(
        color: const Color.fromARGB(255, 0, 0, 0),
        buttonBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          changeSelectedINdex(index);
        },
        index: _selectIndex,
        items: <Widget>[
          Icon(
            Icons.list,
            color: Colors.white,
          ),
          Icon(
            Icons.add,
            color: Colors.white,
          ),
          Icon(
            Icons.info,
            color: Colors.white,
          ),
        ]);
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<CategoryBloc>(context).add(RefreshCategoryEvent());
  }
}
