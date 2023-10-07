import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:share/share.dart';


class PdfViewerPage extends StatelessWidget {
  final String pdfPath = '/storage/emulated/0/Android/data/com.riad.calculator.tax_calculator/files/MyFolder/tax.pdf'; // Replace with your PDF file path

  void sharePdf(String filePath) {
    Share.shareFiles([filePath], text: 'Share PDF');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        actions: [
          ElevatedButton.icon(onPressed: () {
            String pdfPath = '/storage/emulated/0/Android/data/com.riad.calculator.tax_calculator/files/MyFolder/tax.pdf';
            sharePdf(pdfPath);
          }, icon: Icon(Icons.share,color: Colors.black87,), label: Text("Share",style: TextStyle(color: Colors.black87),))
        ],
      ),
      body: Center(
        child: PdfView(
          path: pdfPath,
        ),
      ),
    );
  }
}
