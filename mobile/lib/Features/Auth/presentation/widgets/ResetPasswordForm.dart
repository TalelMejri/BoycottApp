import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.talel.boycott/Features/Auth/domain/entities/Payload.dart';
import 'package:com.talel.boycott/Features/Auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:com.talel.boycott/Features/Auth/presentation/widgets/auth_btn.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});
  @override
 ResetPasswordState createState() {
    return ResetPasswordState();
  }
}

class ResetPasswordState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordconfirm = TextEditingController();
   TextEditingController _token = TextEditingController();
  TextEditingController _email = TextEditingController();

  @override
  void dispose() {
    _token.dispose();
    _email.dispose();
    _password.dispose();
    _passwordconfirm.dispose();;
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
                  return 'Email is required'; 
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              enableSuggestions: false,
                keyboardType: TextInputType.number,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Code is required';
                }
                return null;
              },
              controller: _token,
              decoration:  const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Code',
              ),
            ),
          ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty || _password.text!=_passwordconfirm.text) {
                  return 'Password is required ';
                }
                return null;
              },
              controller: _password,
              decoration:  const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              obscureText: true,
            ),
          ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty || _password.text!=_passwordconfirm.text) {
                  return 'Confirm Password Incorrect';
                }
                return null;
              },
              controller: _passwordconfirm,
              decoration:  const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Confirm Password",
              ),
              obscureText: true,
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
                      text: "Changed Password",
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
      payloadEntity data=payloadEntity(email: _email.text,password: _password.text,token: _token.text);
          BlocProvider.of<SignupBloc>(context).add(
            ResetPasswordEvent(data: data)
          );
    }
  }
}