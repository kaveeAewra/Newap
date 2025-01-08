import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:permission_handler/permission_handler.dart';

class PDFViewerPage extends StatelessWidget {
  final String filePath;

  const PDFViewerPage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        backgroundColor: const Color.fromARGB(255, 150, 207, 237),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              await _downloadPDF(context, filePath);
            },
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: _loadPDF(filePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('Error loading PDF: ${snapshot.error}'));
            }
            return PDFView(
              filePath: snapshot.data!,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<String> _loadPDF(String filePath) async {
    final byteData = await rootBundle.load(filePath);
    final file = await _writeToFile(byteData);
    return file.path;
  }

  Future<File> _writeToFile(ByteData data) async {
    final dir = await getTemporaryDirectory();
    final file =
        File('${dir.path}/temp_${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(data.buffer.asUint8List());
    return file;
  }

  Future<void> _downloadPDF(BuildContext context, String filePath) async {
    if (await _requestPermission(Permission.storage)) {
      try {
        final byteData = await rootBundle.load(filePath);
        final bytes = byteData.buffer.asUint8List();

        final dir = await getExternalStorageDirectory();
        if (dir != null) {
          final file = File(
              '${dir.path}/downloaded_pdf_${DateTime.now().millisecondsSinceEpoch}.pdf');

          await file.writeAsBytes(bytes);

          if (await file.exists()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('PDF downloaded successfully')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to download PDF')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to access storage')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error downloading PDF: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.request();
    return status == PermissionStatus.granted;
  }
}
