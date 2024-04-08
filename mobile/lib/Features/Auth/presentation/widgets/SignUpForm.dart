
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.talel.boycott/Core/utils/validator.dart';
import 'package:com.talel.boycott/Features/Auth/domain/entities/login_entity.dart';
import 'package:com.talel.boycott/Features/Auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:com.talel.boycott/Features/Auth/presentation/widgets/auth_btn.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/widgets/Product_add_update_widgets/text_form_field_widget.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String nom = "";
  String prenom = "";
  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
               const SizedBox(height: 4,),
               Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child:TextFormFieldWidget(
                     initialValue: nom,
                     validation:validateName,
                     onChanged: (value) {
                          nom = value;
                      },
                      hintText: 'Enter your Name',
                      icon: Icons.edit,
                      keyboardType: TextInputType.name,
                      labelText: 'Name',
                      obscuretext: false,
                )),
                 Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child:TextFormFieldWidget(
                     initialValue: prenom,
                     validation:validateName,
                     onChanged: (value) {
                          prenom = value;
                      },
                      hintText: 'Enter your LastName',
                      icon: Icons.edit,
                      keyboardType: TextInputType.text,
                      labelText: 'LastName',
                       obscuretext: false,
                )),
                  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child:TextFormFieldWidget(
                     initialValue: email,
                     validation:validateName,
                     onChanged: (value) {
                          email = value;
                      },
                      hintText: 'user@gmail.com',
                      icon: Icons.edit,
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'Email',
                       obscuretext: false,
                )),
                  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child:TextFormFieldWidget(
                     initialValue: password,
                     validation:validateDescription,
                     onChanged: (value) {
                          password = value;
                      },
                      hintText: '**********',
                      icon: Icons.edit,
                      keyboardType: TextInputType.text,
                      labelText: 'Password',
                       obscuretext: true,
                )),
              
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                if (state is LoadingSignupStateState) {
                  return const CircularProgressIndicator(
                    color: Colors.green,
                  );
                } else {
                  return AuthButton(
                      text: "Sign Up",
                      onPressed: validateFormThenUpdateOrAddProduct,
                      color: Colors.green);
                }
              },
            ),
          ),
          ]),
    );
  }

  void validateFormThenUpdateOrAddProduct() {
    final isValid = _formKey.currentState!.validate();
    
    if (isValid) {
      final user = LoginEntity(
        nom: nom
        ,prenom: prenom
        ,email: email
        ,password: password
      );
        BlocProvider.of<SignupBloc>(context)
            .add(AddUserEvent(user:user ));
    }
  }
}