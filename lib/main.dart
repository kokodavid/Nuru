import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuru/user_interface/screens/on_boarding/onBoarding.dart';
import 'package:nuru/user_interface/screens/on_boarding/splash_screen.dart';

import 'helpers/locator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 736),
      allowFontScaling: false,
      builder: () => MaterialApp(
          title: 'Nuru Report',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white
          ),
          home: SplashScreen()
      ),
    );
  }
}


