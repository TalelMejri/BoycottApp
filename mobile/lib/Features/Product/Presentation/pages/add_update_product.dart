import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.talel.boycott/Core/utils/snack_bar_message.dart';
import 'package:com.talel.boycott/Core/widgets/Loading_widget.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/entities/category.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/bloc/Product/product_bloc.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/bloc/add_delete_update_product/adddeleteupdate_product_bloc.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/pages/Product_pages.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/widgets/Product_add_update_widgets/form_widget.dart';
import 'package:com.talel.boycott/Features/Product/domain/entities/Product.dart';

class ProductAddUpdatePage extends StatelessWidget {
  final Product? product;
  final bool isUpdateProduct;
  final Category category;
  const ProductAddUpdatePage({Key? key, this.product, required this.isUpdateProduct,required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_buildAppbar(),
      body: _buildBody(),
    );
  }
  
  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdateProduct ? "Edit Product"  : "Add Product"));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(10),
          child:
              BlocConsumer<AdddeleteupdateProductBloc, AdddeleteupdateProductState>(
            listener: (context, state) {
              if (state is MessageAddUpdateDeleteProductState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                _onRefresh(context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => ProductPages(category: category,)),
                    (route) => false);
              } else if (state is ErrorAddUpdateDeleteProductState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
             if (state is LoadingAddUpdateDeleteProductState) {
                return LoadingWidget();
             }
              return FormWidgetProduct(isUpdateProduct: isUpdateProduct ? true : false,product:product,category:category);
            },
          )),
    );
  }

   Future<void> _onRefresh(BuildContext context) async{
      BlocProvider.of<ProductBloc>(context).add(GetAllProductEvent(id_categorie: category.id!));
  }
}