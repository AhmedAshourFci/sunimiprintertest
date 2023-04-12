import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class FCITextStyle {
  static TextStyle normal(int fontSize,
      {Color? color,
        String? fontFamily,
        double? height,
        FontStyle? fontStyle}) {
    double ratio=MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .size.height/MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .size.width;
    return TextStyle(
        color: color != null ? color : Colors.black,
        fontFamily: Get.locale!.languageCode == 'ar' ? 'Almarai' : 'Roboto',
        fontWeight: FontWeight.normal,
        fontSize:ScreenUtil().setSp(ratio<1?fontSize*ratio:fontSize),
        height: height,
        fontStyle: fontStyle != null ? fontStyle : FontStyle.normal);
  }

  static TextStyle bold(double fontSize,
      {Color? color,
        String? fontFamily,
        double? height,
        FontStyle? fontStyle}) {
    double ratio=MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .size.height/MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .size.width;
    return TextStyle(
        color: color != null ? color : Colors.black,
        fontFamily: Get.locale!.languageCode == 'ar' ? 'Almarai' : 'Roboto',
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil().setSp(ratio<1?fontSize*ratio:fontSize),
        height: height,
        fontStyle: fontStyle != null ? fontStyle : FontStyle.normal);
  }

  static pw.TextStyle normalPDF(int fontSize,
      {PdfColor? color,
        String? fontFamily,
        double? height,
        pw.FontStyle? fontStyle}) {
    return pw.TextStyle(
        color: color != null ? color : PdfColor.fromHex('#000000'),
        fontWeight: pw.FontWeight.normal,
        fontSize: ScreenUtil().setSp(fontSize),
        height: height,
        fontStyle: fontStyle != null ? fontStyle : pw.FontStyle.normal);
  }

  static pw.TextStyle boldPDF(int fontSize,
      {PdfColor? color,
        String? fontFamily,
        double? height,
        pw.FontStyle? fontStyle}) {
    return pw.TextStyle(
        color: color != null ? color : PdfColor.fromHex('#000000'),
        fontWeight: pw.FontWeight.bold,
        fontSize: ScreenUtil().setSp(fontSize),
        height: height,
        fontStyle: fontStyle != null ? fontStyle : pw.FontStyle.normal);
  }

}

class FCIColors {
  static Color sidebarBackGroundColor() => Color(0xffeaecf8);
  static Color iconColor() => Color(0xffe69736);
  static Color primaryColor() => Color(0xff5268c7);
  static Color accentColor() => Color(0xffa3aebe);
  static Color lightBlueColor() => Color(0xff7f91d4);
  static Color lightColor() => Color(0xfff2f5f9);
  static Color redtColor() => Color(0xffF54768);
  static Color redaccenttColor() => Color(0xff974063);
  static Color blackaccenttColor() => Color(0xff41436A);
  static Color lightorangColor() => Color(0xffFF9677);
  static Color greenColor() => Color(0xff75E2FF);
  static Color greenAccentColor() => Color(0xff98DAD9);
  static Color blueColor() => Color(0xff5689C0);
  static Color blackblueColor() => Color(0xff244D61);

  static Color resPrimaryColor() => Color(0xff812534);
  static Color resAccentColor() => Color(0xffFFB673);
  static Color resBlackaccenttColor() => Color(0xff9C3F1E);
  static Color primaryColorIf({isResturant=false}) =>isResturant? Color(0xff812534):Color(0xff5268c7);
  static Color accentColorIf({isResturant=false}) =>isResturant?Color(0xffFFB673): Color(0xffa3aebe);
  static Color blackaccenttColorIf({isResturant=false}) =>isResturant? Color(0xff9C3F1E): Color(0xff244D61);

}

class FCISize {
  static double width(context) => MediaQuery.of(context).size.width;
  static double height(context) => MediaQuery.of(context).size.height;
  static double iconSize({double iconSize=25}) {
    double ratio=MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .size.height/MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .size.width;
    return ScreenUtil().setSp(ratio<1?iconSize*ratio:iconSize);
  }
}

class FCIPadding {
  static double cardMarginHorizontal = ScreenUtil().setWidth(20);
  static double cardMarginVertical = ScreenUtil().setHeight(20);
  static double textFieldPaddingHorizontal = ScreenUtil().setWidth(5);
  static double textFieldPaddingVertical = ScreenUtil().setHeight(5);
  static double cardPadding = 20;
  static EdgeInsets symmetric({double? width, double? height}) {
    return EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(width ?? 0),
        vertical: ScreenUtil().setHeight(height ?? 0));
  }

  static EdgeInsets only(
      {double? top, double? bottom, double? left, double? right}) {
    return EdgeInsets.only(
        left: ScreenUtil().setWidth(left ?? 0),
        right: ScreenUtil().setWidth(right ?? 0),
        top: ScreenUtil().setHeight(top ?? 0),
        bottom: ScreenUtil().setHeight(bottom ?? 0));
  }
}

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Color(0xFFfbe4b2),
    primarySwatch: Colors.amber,
    primaryColorDark: Color(0xFFC7B285),
    primaryColorLight: Color(0xFFFCF3E1),
    accentColor: Color(0xFFA3A3A3),
    hintColor: Color(0xff8D8D8D),
    dividerColor: Color(0xffEDEDED),
    buttonColor: Color(0xff252B2E),
    scaffoldBackgroundColor: Color(0xffffffff),
    canvasColor: Color(0xffFfffff),
  );
}