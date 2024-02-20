import 'package:flutter/material.dart';
import 'package:mobile/Core/widgets/Loading_widget.dart';
import 'package:mobile/Features/Auth/data/datasource/user_local_data_source.dart';
import 'package:mobile/Features/Auth/data/model/UserModelLogin.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/pages/Category_pages.dart';
import 'package:mobile/Features/Categorie/Presentation/widgets/categories_widgets/MessageDisplayWidget.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';
import 'package:mobile/Features/Product/Presentation/bloc/Product/product_bloc.dart';
import 'package:mobile/Features/Product/Presentation/pages/AllRequestProeuct.dart';
import 'package:mobile/Features/Product/Presentation/pages/add_update_product.dart';
import 'package:mobile/Features/Product/Presentation/widgets/Product_widgets/WidgetListProduct.dart';
import 'package:mobile/injection_container.dart';

class ProductPages extends StatefulWidget {
  final Category category;
  const ProductPages({super.key,required this.category});

  @override
  State<ProductPages> createState() => _ProductPagesState();
}

class _ProductPagesState extends State<ProductPages> {

   final UserLocalDataSource userLocalDataSource=sl.get<UserLocalDataSource>();
 
  @override
  void initState() {
     /*BlocProvider.of<ProductBloc>(context)
            .add(GetAllProductEvent(id_categorie:widget.category.id!));*/
    getAuth();
    super.initState();
  }
  
  UserModelLogin? user=null;

  void getAuth () async{
    var res=await userLocalDataSource.getCachedUser()!=null ? true : false;
    if(res){
      user=await userLocalDataSource.getCachedUser();
    }
    setState(()  {
      auth=res;
    });
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

  AppBar _buildAppBar() => AppBar(title: Text("Product Belong to "+widget.category.name),
     leading: IconButton(onPressed: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>const CategoriePages()));
     },icon: const Icon(Icons.arrow_back)),
     actions: [
       auth && user?.role==1 ? IconButton(onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>( AllRequestProduct(category: widget.category,))));
      }, icon:const Icon(Icons.new_releases))   : Container()
     ],);

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