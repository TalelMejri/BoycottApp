import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.talel.boycott/Features/Auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:com.talel.boycott/Features/Auth/presentation/widgets/auth_btn.dart';

class VerifyForm extends StatefulWidget {
  const VerifyForm({super.key});
  @override
  VerifyFormFormState createState() {
    return VerifyFormFormState();
  }
}

class VerifyFormFormState extends State<VerifyForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _code = TextEditingController();
  TextEditingController _email = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Code is required'; 
                }
                return null;
              },
              keyboardType: TextInputType.number,
              controller: _code,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your Token',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                return null;
              },
              controller: _email,
              decoration:  const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your Email',
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
                      text: "Verify",
                      onPressed: validateAndLoginUser,
                      color: Colors.green);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void validateAndLoginUser() {
    if (_formKey.currentState!.validate()) {
          BlocProvider.of<SignupBloc>(context).add(
            VerifyUserEvent(code: _code.text, email: _email.text)
          );
    }
  }
}