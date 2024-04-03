import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Features/Auth/data/datasource/user_local_data_source.dart';
import 'package:mobile/Features/Auth/presentation/pages/login_pages.dart';
import 'package:mobile/Features/Auth/presentation/pages/signup_pages.dart';
import 'package:mobile/Features/Categorie/Presentation/pages/Category_pages.dart';
import 'package:mobile/Features/Product/Presentation/bloc/Product/product_bloc.dart';
import 'package:mobile/Features/Product/domain/entities/Product.dart';
import 'package:mobile/injection_container.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool auth = false;
  final UserLocalDataSource userLocalDataSource = sl.get<UserLocalDataSource>();

  void getAuth() async {
    var res = await userLocalDataSource.getCachedUser() != null ? true : false;
    setState(() {
      auth = res;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      BlocProvider.of<ProductBloc>(context).add(CheckExisteProductEvent(
          code_fabricant: barcodeScanRes.substring(1, 6)));
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
  }

  void _showProductExistenceAlert(Product productExists) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('boycotted'),
          content: Text(productExists.name +
              " is one of the brands that are supporting Israel and must be boycotted"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void logout() {
    userLocalDataSource.clearCachedUser();
    setState(() {
      auth = false;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  void _showSnackBar(String message, {Color backgroundColor = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<ProductBloc>(context).stream.listen((state) {
      _handleProductState(state);
    });
  }

  void _handleProductState(ProductState state) {
    if (state is LoadedProductExite) {
      _showProductExistenceAlert(state.isExiste);
    } else if (state is ErrorProductState) {
      _showSnackBar(
          "Sorry, this product doesn't match any in our database. We recommend verifying it through its designated channels for your peace of mind.",
          backgroundColor: Colors.red);
    }
  }

  @override
  void initState() {
    getAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("images/back.jpg", fit: BoxFit.cover),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 120.0),
                  const Text(
                    "Support Palestine. Boycott Israel",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Stand with the Palestinians during their fight for freedom, justice, and equality.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 100.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CategoriePages()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        icon: const Icon(Icons.category, color: Colors.red),
                        label: const Text(
                          "Browse Categories",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      ElevatedButton.icon(
                          onPressed: () => scanBarcodeNormal(),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                          label: const Text(
                            "Scan BarCode",
                            style: TextStyle(fontSize: 12),
                          ),
                          icon: const Icon(
                            Icons.qr_code_scanner,
                            color: Colors.red,
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(top: 160),
                    child: Column(children: [
                      Text(
                        "PLEASE NOTE: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "This list is not complete and is constantly being updated. If you know about a brand that should be on the list, please create an account with us then you can add some more.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Thanks for your support.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: !auth,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          icon: const Icon(
                            Icons.account_circle,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "Login",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Visibility(
                        visible: !auth,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                          icon: const Icon(
                            Icons.manage_accounts,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "Signup",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: auth,
                        child: ElevatedButton.icon(
                          onPressed: logout,
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text('© 2024. All rights reserved.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
