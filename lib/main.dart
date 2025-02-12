import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:temp/pages/category.dart';
import 'package:temp/pages/fill_form.dart';
import 'package:temp/pages/home_page.dart';
import 'package:temp/pages/login_page.dart';
import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          initialRoute: '/login',
          debugShowCheckedModeBanner: false,
          routes:{
            '/': (context) => FillForm(),
            '/login':(context) => LoginPage(),
            '/home':(context)=>HomePage(),
            '/category':(context)=>CategoryPage(),
          },
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(1.0),
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}

