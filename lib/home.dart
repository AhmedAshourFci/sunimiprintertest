import 'package:flutter/material.dart';
import 'package:printtest/pdftest.dart';
import 'package:printtest/printer_screen.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import 'dart:typed_data';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'dart:io' as io;

import 'package:printing/printing.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import 'package:pdf/pdf.dart';
import 'dart:typed_data';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'dart:async';

import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'package:flutter/services.dart';

import 'fci_style.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool supportSunmiPrinter=false;
  Future<bool?> _bindingPrinter() async {
    await SunmiPrinter.bindingPrinter().then((result) async{
      if(result!=null && result){
        await SunmiPrinter.serialNumber().then((serial_number) {
          if(serial_number=="NOT FOUND"){
            supportSunmiPrinter=false;
          }else{
            supportSunmiPrinter=true;
          }
        });
      }else{
        supportSunmiPrinter=false;
      }
    });
    print('supportSunmiPrinter ${supportSunmiPrinter}');
    return supportSunmiPrinter;
  }
  @override
  void initState() {
    _bindingPrinter();
    super.initState();
  }
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: ()async{
                Uint8List? bytes;
                setState(() {
                  loading=true;
                });
                await PrintBillByInvoice(
                  context: context,
                )
                    .getPdfBytes().then((value){
                  bytes=value;
                  Get.to(SuccessWidget(bytes: bytes!));
                });
                setState(() {
                  loading=false;
                });
              },
              child:loading?CircularProgressIndicator()
              :Text('Generete Pdf',style: FCITextStyle.bold(25),),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}



