import 'dart:convert';
import 'dart:typed_data';
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
class Data{
  String name;
  double quntity;
  double price;
  Data({required this.name,required this.price,required this.quntity});
}
class PrintBillByInvoice {
  PrintBillByInvoice({
    required this.context
  });

  // final material.Size size;
  material.BuildContext context;
  double fontSizeRow = 8;
  PdfColor blueColor = PdfColor.fromHex('#000080');
  PdfColor lghtColor = PdfColor.fromHex('#fafbf8');
  PdfColor darkColor = PdfColor.fromHex('#edf0ed');
  List<Data>data=[
    Data(name: 'item 1', price: 150, quntity: 10),
    Data(name: 'item 2', price: 40, quntity: 140),
    Data(name: 'item 3', price: 44, quntity: 5),
    Data(name: 'item 4', price: 150, quntity: 1),
    Data(name: 'item 5', price: 404, quntity: 100),
  ];
  Future<Uint8List?> getPdfBytes({bool share=false}) async {
    final ttf = await fontFromAssetBundle('assets/fonts/open-sans.ttf');
    final tffBold = await fontFromAssetBundle('assets/fonts/Cairo-Bold.ttf');
    var image;
      image = await imageFromAssetBundle("assets/images/company_icon.png");

    final doc = Document();
    double totalPrice=0;
    double totalQ=0;
    data.forEach((element) {
      totalPrice+=element.price;
      totalQ+=element.quntity;
    });
    doc.addPage(Page(
        pageFormat: PdfPageFormat.roll57,
        textDirection: TextDirection.rtl,
        build: (Context context) => ListView(
          children: [
            if (image != null)
              Image(image, width:PdfPageFormat.roll57.width, height: 100,
                  fit: BoxFit.fill),
            SizedBox(height: 10),

            Container(
              color: darkColor,
              width:PdfPageFormat.roll57.width,
              alignment: Alignment.center,
              height: 30,
              child:  Text(
                  '  transactionTypesData ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold, font: ttf)),),
            rowSampleDataPDF(
                'Date',
                '${DateTime.now().toString()}',
                '',
                ttf),
            rowSampleDataPDF(
                'Bill No.',
                '16565',
                'رقم الفاتورة',
                ttf),

              rowSampleDataPDF(
                  'Tax Number',
                  '5465456454545454545454545',
                  'الرقم الضريبى',
                  ttf),


            rowDataHeaderPDF(ttf),
            // tableDetailsPDF(ttf),
            rowDataDetailPDF(ttf),

              rowSampleDataPDFTotals(
                'Total',
                '${totalPrice }',
                'الاجمالى',
                ttf,
              ),
            rowSampleDataPDFTotals(
              'Qunt',
              '${totalQ }',
              'الكميات',
              ttf,
            ),

          ],
        )
      //  footer: (context) => footer(svg, sysControl, ttf) // Center
    )  );

    Uint8List? bytes;
    await doc.save().then((data) async {
      bytes=data;
    });

    return bytes;
  }
  Widget rowDataHeaderPDF(TtfFont tff) {
    return Row(
      verticalDirection: VerticalDirection.up,
      children: [
        Flexible(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(30),
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Text(
              'الصنـف\nItem',
              //  maxLines: 2,
              // softWrap: true,
              style: TextStyle(
                  color: PdfColor.fromHex('#000000'), fontSize: 8, font: tff),
              // FCITextStyle.boldPDF(8).copyWith(height: 1.4, font: tff),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(5),
                horizontal: ScreenUtil().setWidth(2)),
            // width: ScreenUtil().setWidth(65),
            height: ScreenUtil().setHeight(30),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(width: 1),
            ),
            child: Center(
              child: Text(
                'الكمــية\nQty',
                style: TextStyle(
                    color: PdfColor.fromHex('#000000'),
                    fontSize: 8,
                    font: tff),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(5),
                horizontal: ScreenUtil().setWidth(2)),
            // width: ScreenUtil().setWidth(65),
            height: ScreenUtil().setHeight(30),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(width: 1),
            ),
            child: Center(
              child: Text(
                'السـعر\nPrice',
                style: TextStyle(
                    color: PdfColor.fromHex('#000000'),
                    fontSize: 8,
                    font: tff),
              ),
            ),
          ),
        ),

      ],
    );
  }


  Row rowDataPDFTotals(
      title,
      data,
      arabic,
      TtfFont tff,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 1,
            child:Container(

                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: PdfColor.fromHex('#000000'),
                    fontSize: 8,
                  ),
                ))),
        Flexible(
            flex: 1,
            child:Container(

              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: PdfColor.fromHex('#000000'), width: 1)),
              child: Text('$data',
                  style: TextStyle(
                      color: PdfColor.fromHex('#000000'),
                      fontSize: 8,
                      font: tff,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            )),
        Flexible(
            flex: 1,
            child:Container(

              child: Text(
                arabic,
                style: TextStyle(
                    color: PdfColor.fromHex('#000000'), fontSize: 8, font: tff),
              ),
            ))
      ],
    );
  }
  Row rowSampleDataPDFTotals(
      title,
      data,
      arabic,
      TtfFont tff,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Container(
        //     width: 55,
        //     alignment: Alignment.centerLeft,
        //     child: Text(
        //       title,
        //       textAlign: TextAlign.right,
        //       style: TextStyle(
        //         color: PdfColor.fromHex('#000000'),
        //         fontSize: 10,
        //       ),
        //     )),
        Flexible(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: PdfColor.fromHex('#000000'), width: 1)),
              child: Text('$data',
                  style: TextStyle(
                      color: PdfColor.fromHex('#000000'),
                      fontSize: 10,
                      font: tff,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            )),
        Flexible(
            flex: 1,
            child: Container(

              child: Text(
                arabic,
                style: TextStyle(
                    color: PdfColor.fromHex('#000000'), fontSize: 10, font: tff),
              ),
            ))
      ],
    );
  }
  Widget rowDataPDFTotalsA4(title, data, arabic, TtfFont tff, bool total) {
    return Container(
        width: PdfPageFormat.a4.width * 0.50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: PdfColor.fromHex('#000000'),
                    fontSize: total ? 14 : 10,
                  ),
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
              alignment: Alignment.center,
              // decoration:  BoxDecoration(
              //     border:
              //     Border.all(color: PdfColor.fromHex('#000000'), width: 1)),
              child: Text('$data',
                  style: TextStyle(
                      color: PdfColor.fromHex('#000000'),
                      fontSize: total ? 16 : 12,
                      font: tff,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            ),
            Container(
              child: Text(
                arabic,
                style: TextStyle(
                    color: PdfColor.fromHex('#000000'),
                    fontSize: total ? 16 : 12,
                    font: tff),
              ),
            )
          ],
        ));
  }

  /// Roll 80

  Container rowSampleDataPDF(
      title,
      data,
      arabic,
      TtfFont tff,
      ) {
    return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Container(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       title,
            //       textAlign: TextAlign.right,
            //       style: TextStyle(
            //         color: PdfColor.fromHex('#000000'),
            //         fontSize: fontSizeRow,
            //       ),
            //     )),
            Container(
              // width: size.width * .5,

              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),

              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border:
                  Border.all(color: PdfColor.fromHex('#FFFFFF'), width: 1)),
              child: Text('$data',
                  style: TextStyle(
                      color: PdfColor.fromHex('#000000'),
                      fontSize: fontSizeRow,
                      font: tff,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            ),
            Container(
              //  width: size.width / 3 - 25,
              child: Text(
                arabic,
                style: TextStyle(
                    color: PdfColor.fromHex('#000000'),
                    fontSize: fontSizeRow,
                    font: tff),
              ),
            )
          ],
        ));
  }
  Widget rowDataDetailPDF(TtfFont tff ) {
    return SizedBox(
      //height: 500,
      child: ListView.builder(
        itemCount:data.length,
        itemBuilder: ((context, index) {
          return Column(
              children: [
                Row(
                  verticalDirection: VerticalDirection.up,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                          alignment: Alignment.center,
                          padding:
                          EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
                          // decoration:  BoxDecoration(border:  Border.all(width: 1)),
                          child:Text(
                            '${data[index].name}',
                            //  maxLines: 2,
                            // softWrap: true,
                            style: TextStyle(
                                color: PdfColor.fromHex('#000000'),
                                fontSize: fontSizeRow,
                                font: tff),
                          )
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          padding:
                          EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
                          // decoration:  BoxDecoration(border:  Border.all(width: 1)),
                          child:Text(
                            '${data[index].quntity}',
                            //  maxLines: 2,
                            // softWrap: true,
                            style: TextStyle(
                                color: PdfColor.fromHex('#000000'),
                                fontSize: fontSizeRow,
                                font: tff),
                          )
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          padding:
                          EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
                          // decoration:  BoxDecoration(border:  Border.all(width: 1)),
                          child:Text(
                            '${data[index].price}',
                            //  maxLines: 2,
                            // softWrap: true,
                            style: TextStyle(
                                color: PdfColor.fromHex('#000000'),
                                fontSize: fontSizeRow,
                                font: tff),
                          )
                      ),
                    ),
                  ],
                ),
              ]
          );
        }),
      ),
    );
  }
}