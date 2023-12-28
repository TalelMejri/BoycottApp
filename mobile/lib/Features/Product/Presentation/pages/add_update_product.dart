import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Core/utils/snack_bar_message.dart';
import 'package:mobile/Core/widgets/Loading_widget.dart';
import 'package:mobile/Features/Product/Presentation/bloc/Product/product_bloc.dart';
import 'package:mobile/Features/Product/Presentation/bloc/add_delete_update_product/adddeleteupdate_product_bloc.dart';
import 'package:mobile/Features/Product/Presentation/widgets/Product_add_update_widgets/form_widget.dart';
import 'package:mobile/Features/Product/domain/entities/Product.dart';


class ProductAddUpdatePage extends StatelessWidget {
  final Product? product;
  final bool isUpdateProduct;
  const ProductAddUpdatePage({Key? key, this.product, required this.isUpdateProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:isUpdateProduct ? _buildAppbar() : null,
      body: _buildBody(),
    );
  }
  
  AppBar _buildAppbar() {
    return AppBar(title: Text("Edit Product" ));
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
                 // _onRefresh(context);
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(builder: (_) => ProductPages()),
                //     (route) => false);
              } else if (state is ErrorAddUpdateDeleteProductState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
             if (state is LoadingAddUpdateDeleteProductState) {
                return LoadingWidget();
             }
              return FormWidgetProduct(isUpdateCategory: false,product:product,);
            },
          )),
    );
  }

 /*   Future<void> _onRefresh(BuildContext context) async{
     BlocProvider.of<ProductBloc>(context).add(RefreshProductEvent());
  }*/
}