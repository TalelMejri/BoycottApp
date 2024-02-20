import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Core/widgets/Loading_widget.dart';
import 'package:mobile/Features/Categorie/Presentation/pages/Category_pages.dart';
import 'package:mobile/Features/Categorie/Presentation/widgets/categories_widgets/MessageDisplayWidget.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';
import 'package:mobile/Features/Product/Presentation/bloc/reject_accept_product/reject_accept_product_bloc.dart';
import 'package:mobile/Features/Product/Presentation/widgets/Product_widgets/product_request_list_widget.dart';

class AllRequestProduct extends StatefulWidget {
 
  final Category category;
  const AllRequestProduct({super.key,required this.category});
  
  @override
  State<AllRequestProduct> createState() => _AllRequestProductState();
}

class _AllRequestProductState extends State<AllRequestProduct> {

@override
void initState() {
  BlocProvider.of<RejectAcceptProductBloc>(context)
            .add(GetAllRequestProductEvent(category_id: widget.category.id!));
  super.initState();
}
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
     leading: IconButton(onPressed: (){ 
       Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriePages()));
      },icon: const Icon(Icons.arrow_back)),
  );


  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<RejectAcceptProductBloc, RejectAcceptProductState>(builder: (context, state) {
        if (state is LoadingRejectAcceptProductState) {
          return const LoadingWidget();
        } else if (state is LoadedRequestProduct) {
           return RequestProductWidget(product: state.product,id:widget.category.id!);
        } else if (state is ErrorRequestProductState) {
          return MessageDisplayWidget(message:state.message);
        } else {
          return const LoadingWidget();
        }
      }),
    );
  }

}