// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

// class DocumentConverter {
//   Future<String> convertDocxToPdf(String docxPath) async {
//     final file = File(docxPath);
//     final docx = await DocxReader().read(file);

//     final pdfFile = await file.parent.createTemp('temp', '.pdf');
//     await PdfWriter().writeContentToPdf(pdfFile.path, docx);

//     return pdfFile.path;
//   }
// }
