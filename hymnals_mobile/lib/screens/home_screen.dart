import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/hymnal_provider.dart';
import './pdf_viewer_screen.dart'; // Import the PDF viewer screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  int _transposeInterval = 0;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;
    await Provider.of<HymnalProvider>(context, listen: false)
        .uploadHymnal(_selectedImage!, _transposeInterval);
  }

  @override
  Widget build(BuildContext context) {
    final hymnalProvider = Provider.of<HymnalProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Hymnals Transposer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedImage != null)
              Image.file(_selectedImage!, height: 200),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Select Image"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Transpose Interval"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _transposeInterval = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            hymnalProvider.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _uploadImage,
                    child: Text("Upload & Transpose"),
                  ),
            SizedBox(height: 20),
            if (hymnalProvider.hymnal != null) ...[
              Text("File Transposed Successfully!",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {
                  String pdfUrl =
                      "http://10.0.2.2:8000/${hymnalProvider.hymnal!.transposedPdf.replaceAll('\\', '/')}";
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PDFViewerScreen(pdfUrl: pdfUrl),
                    ),
                  );
                },
                child: Text("View PDF"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

