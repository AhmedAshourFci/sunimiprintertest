import 'package:flutter/material.dart';
import 'package:printtest/pdftest.dart';
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
class SuccessWidget extends StatelessWidget {
  Uint8List bytes;
  SuccessWidget(
      {Key? key,
        required this.bytes,
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<SuccessWidgetController>(
        init: SuccessWidgetController( ),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Printer Test'),
            ),
            body: Container(
              color: FCIColors.lightColor(),
              margin: FCIPadding.symmetric(width: 5,height: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${'Operation done successfully'.tr} !',style: FCITextStyle.bold(18,color:Colors.green),),
                    SizedBox(height: ScreenUtil().setHeight(5),),
                    Container(
                      width: FCISize.width(context)*0.5,
                      padding: FCIPadding.symmetric(width: 10,height: 5),
                      margin:  FCIPadding.symmetric(width: 10,height: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child:
                      // controller.isLoading.value?Utils.loading():
                      Column(
                        children: [
                          customButton(context,'Print 1 Static text'.tr, Icons.print, Colors.green,
                                  ()async{
                                if(bytes!=null) {
                                  print('Print 1 Start');
                                  controller.changeLoading(true);
                                  final List<int> _escPos = await _customEscPos1();
                                  await SunmiPrinter.initPrinter();
                                  await SunmiPrinter.startTransactionPrint(true);
                                  await SunmiPrinter.printRawData(
                                      Uint8List.fromList(_escPos));
                                  await SunmiPrinter.exitTransactionPrint(true);
                                  print('11111111111111');
                                  controller.changeLoading(false);
                                }
                              }),
                          customButton(context,'print 2 Static image'.tr, Icons.print, Colors.green,
                                  ()async{
                                if(bytes!=null) {
                                  print('Print 2 Start');
                                  controller.changeLoading(true);
                                  final List<int> _escPos = await _customEscPos2();
                                  await SunmiPrinter.initPrinter();
                                  await SunmiPrinter.startTransactionPrint(true);
                                  await SunmiPrinter.printRawData(
                                      Uint8List.fromList(_escPos));
                                  await SunmiPrinter.exitTransactionPrint(true);
                                  print('222222222222222222');
                                  controller.changeLoading(false);
                                }
                              }),

                          customButton(context,'Print 3 dynamic invoice'.tr, Icons.print, Colors.green,
                                  ()async{
                                if(bytes!=null) {
                                  print('Print 3 Start');
                                  controller.changeLoading(true);
                                  final List<int> _escPos = await _customEscPos3(bytes);
                                  await SunmiPrinter.initPrinter();
                                  await SunmiPrinter.startTransactionPrint(true);
                                  await SunmiPrinter.printRawData(
                                      Uint8List.fromList(_escPos));
                                  await SunmiPrinter.exitTransactionPrint(true);
                                  print('333333333333');
                                  controller.changeLoading(false);
                                }
                              }),
                          customButton(context,'Preview'.tr, Icons.video_label,FCIColors.blackaccenttColorIf(),
                                  ()async{
                                if(bytes!=null) {
                                  await Printing.layoutPdf(
                                      onLayout: (
                                          PdfPageFormat format) async => bytes );

                                }
                              }),
                          customButton(context,'Back',Icons.arrow_forward,  FCIColors.blueColor(),
                                  (){
                                Get.back();
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
  Widget customButton(context,text,icon,color,onTap){
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius:BorderRadius.circular(25)
        ),
        width: FCISize.width(context)*0.5,
        alignment: Alignment.center,
        padding: FCIPadding.symmetric(width: 5,height: 5),
        margin:  FCIPadding.symmetric(height: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('${text}',style: FCITextStyle.bold(16,color:Colors.white),),
            Icon(icon,color: Colors.white,size: FCISize.iconSize(),)
          ],
        ),
      ),
    );
  }
  Future<List<int>> _customEscPos1() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

    bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
    bytes +=
        generator.text('Reverse text', styles: const PosStyles(reverse: true));
    bytes += generator.text('Underlined text',
        styles: const PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left',
        styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right',
        styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
    bytes += generator.qrcode('Barcode by escpos',
        size: QRSize.Size4, cor: QRCorrection.H);
    bytes += generator.feed(2);

    bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    bytes += generator.text('Text size 200%',
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    bytes += generator.reset();
    bytes += generator.cut();
    print('111111111 $bytes');

    return bytes;
  }
  Future<List<int>> _customEscPos2() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];
    final ByteData data = await rootBundle.load('assets/images/company_icon.png');
    final Uint8List imageBytes = data.buffer.asUint8List();
    final img.Image? image = img.decodeImage(imageBytes);
    bytes += generator.image(image! );
    bytes += generator.reset();
    bytes += generator.cut();

    return bytes;
  }
  Future<List<int>> _customEscPos3(bytesDat) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];
    await Printing.raster(bytesDat,pages: [0],dpi: 72).forEach((element) {
      {
        img.Image image=element.asImage();
        bytes+=generator.image(image);
        bytes+=generator.feed(2);
      }
    });
    bytes += generator.feed(2);
    bytes += generator.reset();
    bytes += generator.cut();
    return bytes;
  }
}
enum PDFGeneratorType{
  print,
  preview,
  share
}

class SuccessWidgetController extends GetxController {
  RxBool isLoading = false.obs;
  changeLoading(val){
    isLoading.value=val;
    update();
  }
  String data='nulllllll';
  changeData(val){
    data=val;
    update();
  }
}