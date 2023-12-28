import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Core/utils/validator.dart';
import 'package:mobile/Features/Categorie/Presentation/pages/Category_pages.dart';
import 'package:mobile/Features/Categorie/domain/entities/category.dart';
import 'package:mobile/Features/Product/Presentation/bloc/add_delete_update_product/adddeleteupdate_product_bloc.dart';
import 'package:mobile/Features/Product/Presentation/widgets/Product_add_update_widgets/form_submit_btn.dart';
import 'package:mobile/Features/Product/Presentation/widgets/Product_add_update_widgets/text_form_field_widget.dart';
import 'package:mobile/Features/Product/domain/entities/Product.dart';


class FormWidgetProduct extends StatefulWidget {
  final bool isUpdateProduct;
  final Product? product;
  final Category category;
  const FormWidgetProduct({
    Key? key,
    required this.isUpdateProduct,
    this.product,
    required this.category
  }) : super(key: key);

  @override
  State<FormWidgetProduct> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidgetProduct> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String photo = "";
  File ? imagePicker;
  String description="";
  String base64Image="";
  String imageError="";

  @override
  void initState() {
    if (widget.isUpdateProduct) {
      name = widget.product!.name;
      base64Image = widget.product!.photo;
      description=widget.product!.description;
    }
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
               const SizedBox(height: 50,),
               TextFormFieldWidget(
                     initialValue: name,
                     validation:validateName,
                     onChanged: (value) {
                          name = value;
                      },
                      hintText: 'Enter your name',
                      icon: Icons.edit,
                      keyboardType: TextInputType.name,
                      labelText: 'Name',
                ),
                 TextFormFieldWidget(
                     initialValue: description,
                     validation:validateDescription,
                     onChanged: (value) {
                          description = value;
                      },
                      hintText: 'Enter your Description',
                      icon: Icons.edit,
                      keyboardType: TextInputType.text,
                      labelText: 'Description',
                ),
                const SizedBox(
                     height: 30.0,
                ),
                Visibility(
                     visible: widget.isUpdateProduct ? true : false,
                     child: Image.memory(
                      base64Decode((base64Image).split(',').last),
                      width: 200,
                      height: 100,
                 ),
                 ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 ElevatedButton(onPressed: (){onChangeImage(ImageSource.gallery);}, child: const Text("Chose Your Photo")),
                 imagePicker==null ? const Text("No Image Selected") : Image.file(imagePicker!,width: 50),
                ],
            ),
            Text(imageError.isNotEmpty ? imageError : '',style: const TextStyle(color: Colors.red),),
               const SizedBox(
                     height: 15.0,
                ),
            FormSubmitBtn(
                isUpdateProduct: widget.isUpdateProduct,
                onPressed: validateFormThenUpdateOrAddProduct),
          ]),
    );
  }

  void validateFormThenUpdateOrAddProduct() {
    final isValid = _formKey.currentState!.validate();
     if(imagePicker==null && !widget.isUpdateProduct){
        setState(() {
          imageError="Image Required";
        });
        return;
      }
    
    if (isValid) {
      final product = Product(
          id: widget.isUpdateProduct ? widget.product!.id : null,
          name: name,
          photo: base64Image,
          description: description,
          id_categorie: widget.category.id!,
      );
      if (widget.isUpdateProduct) {
        BlocProvider.of<AdddeleteupdateProductBloc>(context)
            .add(UpdateProductEvent(product:product));
      } else {
        BlocProvider.of<AdddeleteupdateProductBloc>(context)
            .add(AddProductEvent(product: product));
      }
    }
  }
}