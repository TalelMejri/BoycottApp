import 'package:flutter/material.dart';
import 'package:com.talel.boycott/Core/widgets/Loading_widget.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/pages/Category_pages.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/widgets/categories_widgets/MessageDisplayWidget.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/entities/category.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/bloc/Product/product_bloc.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/pages/AllRequestProeuct.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/pages/add_update_product.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/widgets/Product_widgets/WidgetListProduct.dart';
import 'package:com.talel.boycott/injection_container.dart';

class ProductPages extends StatefulWidget {
  final Category category;
  const ProductPages({super.key,required this.category});

  @override
  State<ProductPages> createState() => _ProductPagesState();
}

class _ProductPagesState extends State<ProductPages> {

 
  @override
  void initState() {
    super.initState();
  }
  

  
  
  int _selectIndex=0;
  bool auth=false;
  

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: auth ? _buildFloatingBtn(context) : null,
    );
  }

  AppBar _buildAppBar() => AppBar(title: Text("Items under the "+widget.category.name +" brand"),
     leading: IconButton(onPressed: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>const CategoriePages()));
     },icon: const Icon(Icons.arrow_back)),
     );

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is LoadingCategoryState) {
          return const LoadingWidget();
        } else if (state is LoadedProduct) {
            return WidgetListProduct(product:state.products,category:widget.category);
        } else if (state is ErrorProductState) {
          return MessageDisplayWidget(message:state.message);
        } else {
          return const LoadingWidget();
        }
      }),
    );
  }

  Widget _buildFloatingBtn(context) {
    return 
      FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductAddUpdatePage(
          isUpdateProduct: false,category:widget.category)));
      },child: const Icon(Icons.add));
  }


 

}