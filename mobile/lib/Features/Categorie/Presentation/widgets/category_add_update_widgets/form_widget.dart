import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.talel.boycott/Core/Strings/constantes.dart';
import 'package:com.talel.boycott/Core/utils/validator.dart';
import 'package:com.talel.boycott/Core/widgets/custom_scaffold.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/bloc/add_delete_update_category/adddeleteupdate_category_bloc.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/widgets/category_add_update_widgets/form_submit_btn.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/widgets/category_add_update_widgets/text_form_field_widget.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/entities/category.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdateCategory;
  final Category? category;
  const FormWidget({
    Key? key,
    required this.isUpdateCategory,
    this.category,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String photo = "";
  late File imagePicker = File('path');
  late File selectedImage = File('path');
  String imageError = "";

  @override
  void initState() {
    if (widget.isUpdateCategory) {
      imagePicker = File(widget.category!.photo.path);
      name = widget.category!.name;
    }
    super.initState();
  }

  Future<void> onChangeImage(ImageSource source) async {
    try {
      XFile? pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          selectedImage = File(pickedImage.path);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 2,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        !widget.isUpdateCategory
                            ? 'Add Category '
                            : "Update Category",
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      TextFormFieldWidget(
                        initialValue: name,
                        validation: validateName,
                        onChanged: (value) {
                          name = value;
                        },
                        hintText: 'Enter your name',
                        icon: Icons.edit,
                        keyboardType: TextInputType.name,
                        labelText: 'Name',
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Visibility(
                        visible: widget.isUpdateCategory ? true : false,
                        child: CachedNetworkImage(
                          width: 100,
                          height: 100,
                          imageUrl: BASE_URL_STORAGE + imagePicker.path,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              onChangeImage(ImageSource.gallery);
                            },
                            child: const Text("Choose Your Photo"),
                          ),
                          selectedImage.path == 'path'
                              ? const Text("No Image Selected")
                              : Image.file(selectedImage, width: 50),
                        ],
                      ),
                      Text(
                        imageError.isNotEmpty ? imageError : '',
                        style: const TextStyle(color: Colors.red),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FormSubmitBtn(
                          isUpdateCategory: widget.isUpdateCategory,
                          onPressed: validateFormThenUpdateOrAddPost,
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                            child: Text(
                              'Thank you for your support',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();
    if (imagePicker == null && !widget.isUpdateCategory) {
      setState(() {
        imageError = "Image Required";
      });
      return;
    }
    if (isValid) {
      final category = Category(
        id: widget.isUpdateCategory ? widget.category!.id : null,
        name: name,
        photo: selectedImage,
      );
      if (widget.isUpdateCategory) {
        BlocProvider.of<AdddeleteupdateCategoryBloc>(context)
            .add(UpdateCategoryEvent(category: category));
      } else {
        BlocProvider.of<AdddeleteupdateCategoryBloc>(context)
            .add(AddCategoryEvent(category: category));
      }
    }
  }
}
