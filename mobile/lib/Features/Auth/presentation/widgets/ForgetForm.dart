import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Features/Auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:mobile/Features/Auth/presentation/widgets/auth_btn.dart';

class ForgetForm extends StatefulWidget {
  const ForgetForm({super.key});
  @override
  ForgetFormState createState() {
    return ForgetFormState();
  }
}

class ForgetFormState extends State<ForgetForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email Required';
                }
                return null;
              },
              controller: _email,
              decoration:  const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                if (state is LoadingSignupStateState) {
                  return const CircularProgressIndicator(
                    color: Colors.green,
                  );
                } else {
                  return AuthButton(
                      text: "Forget Password",
                      onPressed: validateAndForegetPasswordUser,
                      color: Colors.green);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void validateAndForegetPasswordUser() {
    if (_formKey.currentState!.validate()) {
          BlocProvider.of<SignupBloc>(context).add(
            ForgetPasswordEvent(email: _email.text)
          );
    }
  }
}