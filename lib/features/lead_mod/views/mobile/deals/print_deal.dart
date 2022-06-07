import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../../core/core.dart';

class PrintDeal extends StatelessWidget {
  const PrintDeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice'),
        actions: actionsMenu(context),
      ),
      body: PdfPreview(
        build: (format) => _generatePdf(format, 'Test Invoive PDF'),
        dynamicLayout: false,
        canChangeOrientation: false,
        initialPageFormat: PdfPageFormat.a4,
        canDebug: false,
        previewPageMargin: const EdgeInsets.all(20),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(
      version: PdfVersion.pdf_1_5,
      compress: true,
      title: 'Invoice',
      creator: 'LeadsBook',
    );
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        clip: true,
        margin: const pw.EdgeInsets.all(20),
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pageHeader(font),
              pw.Divider(),
              pageBody(),
              pw.Divider(),
              pageFooter(font),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.Expanded pageBody() => pw.Expanded(
        child: pw.Container(),
      );

  pw.SizedBox pageFooter(pw.Font font) {
    return pw.SizedBox(
      width: double.infinity,
      child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: 20),
            ),
            pw.Text(
              'Created By: LeadsBook v:3.0',
              style: pw.TextStyle(font: font, fontSize: 14),
            ),
          ]),
    );
  }

  pw.SizedBox pageHeader(pw.Font font) {
    return pw.SizedBox(
      width: double.infinity,
      child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Hello Text',
              style: pw.TextStyle(font: font, fontSize: 20),
            ),
            pw.Text(
              'Hello Text',
              style: pw.TextStyle(font: font, fontSize: 20),
            ),
          ]),
    );
  }
}
