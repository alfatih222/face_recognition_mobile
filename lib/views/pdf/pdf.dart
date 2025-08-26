import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPreviewPage extends StatelessWidget {
  final String pdfUrl;

  const PdfPreviewPage({Key? key, required this.pdfUrl}) : super(key: key);

  Future<void> _downloadPdf(BuildContext context) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        pdfUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      const downloadDirPath = '/storage/emulated/0/Download';
      final fileName = p.basename(pdfUrl);
      final savePath = p.join(downloadDirPath, fileName);

      final file = File(savePath);
      await file.writeAsBytes(response.data);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Saved to $savePath')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to download: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview PDF'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Download PDF',
            onPressed: () => _downloadPdf(context),
          ),
        ],
      ),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
