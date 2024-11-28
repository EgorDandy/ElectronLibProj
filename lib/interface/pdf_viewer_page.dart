import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatelessWidget {
  final String? filePath;
  final String name;

  const PDFViewerPage({super.key, required this.filePath, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: PDFView(
        filePath: filePath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
        onRender: (pages) {
          //print('Рендеринг завершен');
        },
        onError: (error) {
          //print(error.toString());
        },
        onPageError: (page, error) {
          //print('$page: ${error.toString()}');
        },
      ),
    );
  }
}