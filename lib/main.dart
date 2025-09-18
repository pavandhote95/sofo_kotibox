import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sofo/app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    Stripe.publishableKey = "pk_test_xxxxxxxx"; // test key
  // ✅ Always first
  await GetStorage.init(); // ✅ Storage init after binding

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sofo",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
