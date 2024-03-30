import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Features/Auth/data/datasource/user_local_data_source.dart';
import 'package:mobile/Features/Auth/presentation/pages/login_pages.dart';
import 'package:mobile/Features/Auth/presentation/pages/signup_pages.dart';
import 'package:mobile/Features/Categorie/Presentation/pages/Category_pages.dart';
import 'package:mobile/Features/Product/Presentation/bloc/Product/product_bloc.dart';
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
      // FlutterBarcodeScanner.getBarcodeStreamReceiver(
      //         '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
      //     .listen((barcode) => setState(() {
      //           print(barcode);
      //         }));
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
        
      print(barcodeScanRes.substring(1,6));
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
  }

  void test() {
    BlocProvider.of<ProductBloc>(context)
        .add(CheckExisteProductEvent(code_fabricant: "1"));
  }

  void logout() {
    userLocalDataSource.clearCachedUser();
    setState(() {
      auth = false;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => scanBarcodeNormal(),
                      child: const Text('BarCode Scan')),
                  SafeArea(
                    child: BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                      if (state is LoadedProductExite) {
                        print("ok");
                        // SnackBarMessage().showSuccessSnackBar(message: "ddddd", context: context);
                      } else if (state is ErrorProductState) {
                        print("no");
                        //  SnackBarMessage().showErrorSnackBar(message: "ddddd", context: context);
                        print(state.message);
                      }
                      return Text("d");
                    }),
                  ),
                  ElevatedButton(onPressed: test, child: Text("test")),
                  const Text(
                    "Support Palestine. Boycott Israel",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Stand with the Palestinians in their struggle for freedom, justice, and equality. While our governments financially support the apartheid state, we don't have to. PLEASE NOTE: This list is not complete and is constantly being added to. If you know about a brand that should be on the list, please use the Something missing button below to submit it. Thanks.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CategoriePages()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      "Browse Categories",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
