import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Core/widgets/LandingPage.dart';
import 'package:mobile/Features/Auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:mobile/Features/Auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/RequestCategory/request_category_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/accept_reject_category/accept_category_bloc_bloc.dart';
import 'package:mobile/Features/Categorie/Presentation/bloc/add_delete_update_category/adddeleteupdate_category_bloc.dart';
import 'package:mobile/Features/Product/Presentation/bloc/Product/product_bloc.dart';
import 'package:mobile/Features/Product/Presentation/bloc/add_delete_update_product/adddeleteupdate_product_bloc.dart';
import 'package:mobile/Features/Product/Presentation/bloc/reject_accept_product/reject_accept_product_bloc.dart';
import 'core/app_theme.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<CategoryBloc>()..add(GetAllCategoryEvent())),
        BlocProvider(create: (_) => di.sl<AdddeleteupdateCategoryBloc>()),
        BlocProvider(create: (_) => di.sl<AcceptCategoryBlocBloc>()),
        BlocProvider(create: (_) => di.sl<RequestBloc>()),
        BlocProvider(create: (_) => di.sl<ProductBloc>()),
        BlocProvider(create: (_) => di.sl<RejectAcceptProductBloc>()),
        BlocProvider(create: (_) => di.sl<AdddeleteupdateProductBloc>()),
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<SignupBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BycottApp',
        theme: appTheme,
        home: const LandingPage(),
      ),
    );
  }
}