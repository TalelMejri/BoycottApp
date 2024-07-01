import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.talel.boycott/Core/Strings/constantes.dart';
import 'package:com.talel.boycott/Core/utils/snack_bar_message.dart';
import 'package:com.talel.boycott/Core/utils/validator.dart';
import 'package:com.talel.boycott/Core/widgets/custom_scaffold.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/entities/category.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/bloc/add_delete_update_product/adddeleteupdate_product_bloc.dart';
import 'package:com.talel.boycott/Features/Product/Presentation/widgets/Product_add_update_widgets/form_submit_btn.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/widgets/category_add_update_widgets/text_form_field_widget.dart';
import 'package:com.talel.boycott/Features/Product/domain/entities/Product.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

class FormWidgetProduct extends StatefulWidget {
  final bool isUpdateProduct;
  final Product? product;
  final Category category;
  const FormWidgetProduct(
      {Key? key,
      required this.isUpdateProduct,
      this.product,
      required this.category})
      : super(key: key);

  @override
  State<FormWidgetProduct> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidgetProduct> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String photo = "";
  String description = "";
  String code_fabricant = "null";
  late File imagePicker = File('path');
  late File selectedImage = File('path');
  String imageError = "";

  @override
  void initState() {
    if (widget.isUpdateProduct) {
      imagePicker = File(widget.product!.photo.path);
      name = widget.product!.name;
      description = widget.product!.description;
      code_fabricant = widget.product!.code_fabricant;
    }
    super.initState();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
          setState(() {
            code_fabricant = barcodeScanRes.substring(1,6);
          });
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
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
            flex: 1,
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
                        !widget.isUpdateProduct
                            ? 'Add Product '
                            : "Update Product",
                        style: const TextStyle(
                          fontSize: 22.0,
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
                      TextFormFieldWidget(
                        initialValue: description,
                        validation: validateDescription,
                        onChanged: (value) {
                          description = value;
                        },
                        hintText: 'Enter your description',
                        icon: Icons.edit,
                        keyboardType: TextInputType.text,
                        labelText: 'Description',
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Visibility(
                        visible: widget.isUpdateProduct ? true : false,
                        child: CachedNetworkImage(
                          width: 100,
                          height: 100,
                          imageUrl: BASE_URL_STORAGE + imagePicker.path,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
                      ElevatedButton(
                          onPressed: () => scanBarcodeNormal(),
                          child: const Text('BarCode Scan')),
                      SizedBox(
                        width: double.infinity,
                        child: FormSubmitBtn(
                          isUpdateProduct: widget.isUpdateProduct,
                          onPressed: validateFormThenUpdateOrAddProduct,
                        ),
                      ),
                      const SizedBox(
                        height: 18.0,
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
                              horizontal: 8,
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

  void validateFormThenUpdateOrAddProduct() {
    final isValid = _formKey.currentState!.validate();
    if (imagePicker == null && !widget.isUpdateProduct) {
      setState(() {
        imageError = "Image Required";
      });
      return;
    }

    if(code_fabricant==""){
      setState(() {
         SnackBarMessage().showErrorSnackBar(message: "Scan the required manufacturer code", context: context);
      });
      return;
    }

    if (isValid) {
      final product = Product(
          id: widget.isUpdateProduct ? widget.product!.id : null,
          name: name,
          photo: selectedImage,
          description: description,
          id_categorie: widget.category.id.toString()!,
          code_fabricant: code_fabricant);
      if (widget.isUpdateProduct) {
        BlocProvider.of<AdddeleteupdateProductBloc>(context)
            .add(UpdateProductEvent(product: product));
      } else {
        BlocProvider.of<AdddeleteupdateProductBloc>(context)
            .add(AddProductEvent(product: product));
      }
    }
  }
}
