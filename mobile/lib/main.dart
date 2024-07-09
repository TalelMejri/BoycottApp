import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.talel.boycott/Core/widgets/LandingPage.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/bloc/RequestCategory/request_category_bloc.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/bloc/accept_reject_category/accept_category_bloc_bloc.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/bloc/add_delete_update_category/adddeleteupdate_category_bloc.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/bloc/Product/product_bloc.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/bloc/add_delete_update_product/adddeleteupdate_product_bloc.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/bloc/reject_accept_product/reject_accept_product_bloc.dart';
import 'core/app_theme.dart';
import 'injection_container.dart' as di;
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({key});

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BoycottBZ',
        theme: appTheme,
        home: const LandingPage(),
      ),
    );
  }
}