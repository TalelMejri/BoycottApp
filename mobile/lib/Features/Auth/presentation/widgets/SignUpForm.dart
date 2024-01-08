import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Core/utils/validator.dart';
import 'package:mobile/Features/Auth/domain/entities/login_entity.dart';
import 'package:mobile/Features/Auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:mobile/Features/Auth/presentation/widgets/auth_btn.dart';
import 'package:mobile/Features/Product/Presentation/widgets/Product_add_update_widgets/text_form_field_widget.dart';

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
  String photo = "";
  String password = "";
  File ? imagePicker;
  String base64Image="";
  String imageError="";

  @override
  void initState() {
    super.initState();
  }

  Future<void> onChangeImage(ImageSource source)async{
    try{
      XFile ? pickeImage=await ImagePicker().pickImage(source: source);
      if(pickeImage!=null){
              final bytes = await (pickeImage).readAsBytes();
        setState(() {
              final bytes = File(pickeImage!.path).readAsBytesSync();
              imagePicker=File(pickeImage.path);
              base64Image =  "data:image/png;base64,"+base64Encode(bytes);
        });
      }else{
        imageError="Image Required";
      }
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
               const SizedBox(height: 4,),
               TextFormFieldWidget(
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
                ),
                 TextFormFieldWidget(
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
                ),
                  TextFormFieldWidget(
                     initialValue: email,
                     validation:validateName,
                     onChanged: (value) {
                          email = value;
                      },
                      hintText: 'fouln@gmail.com',
                      icon: Icons.edit,
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'Email',
                       obscuretext: false,
                ),
                  TextFormFieldWidget(
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
                ),
               Padding(
                padding: EdgeInsets.all(2),
                child: 
                 Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 ElevatedButton(onPressed: (){onChangeImage(ImageSource.gallery);}, child: const Text("Chose Your Photo")),
                 imagePicker==null ? const Text("No Image Selected") : Image.file(imagePicker!,width: 50),
                ],
            )),
            Text(imageError.isNotEmpty ? imageError : '',style: const TextStyle(color: Colors.red),),
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
     if(imagePicker==null){
        setState(() {
          imageError="Image Required";
        });
        return;
      }
    
    if (isValid) {
      final user = LoginEntity(
        nom: nom
        ,prenom: prenom
        ,email: email
        ,password: password
        ,photo: base64Image
      );
        BlocProvider.of<SignupBloc>(context)
            .add(AddUserEvent(user:user ));
    }
  }
}