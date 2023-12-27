import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile/Core/widgets/Loading_widget.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/widgets/categories_widgets/MessageDisplayWidget.dart';
import 'package:mobile/Features/Categorie/Presentation/widgets/categories_widgets/posts_list_widgets.dart';

class CategoriePages extends StatefulWidget {
  const CategoriePages({super.key});

  @override
  State<CategoriePages> createState() => _CategoriePagesState();
}

class _CategoriePagesState extends State<CategoriePages> {

  int _selectIndex=0;
  bool auth=true;

  void changeSelectedINdex(int index){
    setState(() {
      _selectIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: auth ?  _buildBottomNavigationBar() : null,
      //floatingActionButton: _buildFloatingBtn(context),
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
                child: _selectIndex==0 ? CatgeoryListWidget(category: state.categorys) : Text("ss") , 
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

  Widget _buildBottomNavigationBar() {
    return 
      CurvedNavigationBar(
      color:Color.fromARGB(255, 47, 15, 73),
      buttonBackgroundColor:Color.fromARGB(255, 47, 15, 73),
      backgroundColor:Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration:const  Duration(milliseconds: 600),
      onTap: (index){changeSelectedINdex(index);},
      index: _selectIndex,
       items:<Widget> [
         Icon(Icons.list,color: Colors.white,),
         Icon(Icons.add,color: Colors.white,),
     ]);
  }

  //   Widget _buildFloatingBtn(BuildContext context) {
  //   return FloatingActionButton(
  //     onPressed: () {
  //       // Navigator.push(
  //       //     context,
  //       //     MaterialPageRoute(
  //       //         builder: (_) => const PostAddUpdatePage(
  //       //               isUpdatePost: false,
  //       //             )));
  //     },
  //     child: const Icon(Icons.add),
  //   );
  // }

  Future<void> _onRefresh(BuildContext context) async{
     BlocProvider.of<CategoryBloc>(context).add(RefreshCategoryEvent());
  }

}