
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:printtest/home.dart';

import 'fci_style.dart';

void main() {
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({super.key, });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(480, 800),
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale:   const Locale('en', 'US') ,

        fallbackLocale: const Locale('ar', 'EG'),
        enableLog: true,
        title: 'AlYosrePOS',


        theme: ThemeData(
          primaryColor: FCIColors.primaryColor(),
          fontFamily: 'Almarai',
          visualDensity: VisualDensity.adaptivePlatformDensity,

          primarySwatch: Colors.blue,
        ),

         home: MyHomePage(title: 'Sunimi printer Test',),//SplashScreen(),//AuthenticationView(),

      ),
    );
  }
}