import 'package:flutter/material.dart';
import 'package:mobile/Core/widgets/LandingPage.dart';
import 'package:mobile/Core/widgets/Loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/RequestCategory/request_category_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/widgets/categories_widgets/MessageDisplayWidget.dart';
import 'package:mobile/Features/Categorie/Presentation/widgets/categories_widgets/request_list_widgets.dart';

class AllRequest extends StatefulWidget {
  const AllRequest({super.key});
 
  @override
  State<AllRequest> createState() => _AllRequestState();
}

class _AllRequestState extends State<AllRequest> {



@override
void initState() {
  BlocProvider.of<RequestBloc>(context)
            .add(GetAllRequestCategoryEvent(status: 0));
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
       Navigator.push(context, MaterialPageRoute(builder: (context)=>LandingPage()));
      },icon: const Icon(Icons.arrow_back)),
  );


  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<RequestBloc, RequestCategoryState>(builder: (context, state) {
        if (state is LoadingCategoryREquestState) {
          return const LoadingWidget();
        } else if (state is LoadedRequest) {
            return RequestCategoryListWidget(category: state.categorys);
        } else if (state is ErrorRequestState) {
          return MessageDisplayWidget(message:state.message);
        } else {
          return const LoadingWidget();
        }
      }),
    );
  }

}