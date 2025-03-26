import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

class PDFViewerScreen extends StatefulWidget {
  final String pdfUrl;

  PDFViewerScreen({required this.pdfUrl});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String localPath = "";
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _downloadForPreview();
  }

  /// 📌 **Download PDF for Viewing**
  Future<void> _downloadForPreview() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/preview.pdf');

      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        localPath = file.path;
        loading = false;
      });
    } catch (e) {
      print("Error downloading preview: $e");
    }
  }

  /// 📥 **Download PDF to Device Storage**
  Future<void> _downloadAndSavePDF() async {
    if (await Permission.storage.request().isGranted) {
      try {
        final response = await http.get(Uri.parse(widget.pdfUrl));

        final dir = await getExternalStorageDirectory();
        final file = File('${dir!.path}/transposed_hymnal.pdf');

        await file.writeAsBytes(response.bodyBytes);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("PDF downloaded to ${file.path}")),
        );

        OpenFile.open(file.path); // Open the downloaded file
      } catch (e) {
        print("Error saving PDF: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Download failed")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Storage permission denied")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transposed PDF")),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(child: PDFView(filePath: localPath)), // 📜 View PDF
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _downloadAndSavePDF,
                      icon: Icon(Icons.download),
                      label: Text("Download PDF"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        OpenFile.open(localPath);
                      },
                      icon: Icon(Icons.picture_as_pdf),
                      label: Text("View Full PDF"),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
    );
  }
}
