import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Core/utils/snack_bar_message.dart';
import 'package:mobile/Features/Auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:mobile/Features/Auth/presentation/widgets/login_form.dart';
import 'package:mobile/Features/Categorie/Presentation/pages/Category_pages.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          Navigator.push(context,
           MaterialPageRoute(builder: (context)=>const CategoriePages()));
        } else if (state is AuthErrorState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme:
              IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        body: LoginForm(),
      ),
    );
  }
}