import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileUploadPage extends StatefulWidget {
  final Function(File, String) onFileUploaded;

  const FileUploadPage({required this.onFileUploaded, super.key});

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  File? _file;
  String? _fileName;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (result != null) {
        setState(() {
          _file = File(result.files.single.path!);
          _fileName = result.files.single.name;
        });

        widget.onFileUploaded(_file!, _fileName!);
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 234, 234),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 150, 207, 237),
        shadowColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Upload PDF',
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 25, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_file != null)
              Column(
                children: [
                  Icon(Icons.picture_as_pdf, size: 100, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    _fileName ?? '',
                    style: const TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ],
              )
            else
              const Text(
                'No file selected',
                style: TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 30, 28, 28)),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 2, 32, 1),
              ),
              child: const Text(
                'Pick PDF File',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
