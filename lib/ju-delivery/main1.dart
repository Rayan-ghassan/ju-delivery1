import 'package:fip8/ju-delivery/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../firebase_options.dart';
import 'menu/saj/saj-menu-controller.dart';


void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartProvider()),
    ],
    child: Myapp5(),
  ),);

}

class Myapp5 extends StatelessWidget {
  const Myapp5({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,

    );
  }
}
