import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Core/utils/snack_bar_message.dart';
import 'package:mobile/Features/Auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:mobile/Features/Auth/presentation/pages/signup_pages.dart';
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
              MaterialPageRoute(builder: (context) => const CategoriePages()));
        } else if (state is AuthErrorState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Image.asset(
                    'images/image1.png',
                    height: 200,
                    width: 200,
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                          top: 5.0, bottom: 20.0, left: 20.0, right: 20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Welcome Back !',
                              style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ])),
                  const LoginForm(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account ?',
                        style: TextStyle(fontSize: 15.0, color: Colors.red),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()));
                        },
                        child: const Text(
                          ' Sign Up',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.red,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ])),
          )),
    );
  }
}
