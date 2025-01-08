import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'pdf_viewer_page.dart';

class NoteDetailPage extends StatefulWidget {
  final String noteTitle;
  final List<Map<String, dynamic>> pdfFiles;

  const NoteDetailPage(
      {super.key, required this.noteTitle, required this.pdfFiles});

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteTitle),
        backgroundColor: const Color.fromARGB(255, 150, 207, 237),
      ),
      body: Container(
        color: const Color.fromARGB(255, 209, 234, 234),
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: widget.pdfFiles.length,
          itemBuilder: (context, index) {
            final pdfFile = widget.pdfFiles[index];
            return Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.picture_as_pdf),
                  title: Text(pdfFile['title']!),
                  trailing: SmoothStarRating(
                    allowHalfRating: false,
                    onRatingChanged: (v) {
                      setState(() {
                        pdfFile['rating'] = v;
                      });
                    },
                    starCount: 5,
                    rating: pdfFile['rating'] ?? 0.0,
                    size: 20.0,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    color: Colors.yellow,
                    borderColor: Colors.yellow,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFViewerPage(
                          filePath: pdfFile['filePath']!,
                        ),
                      ),
                    );
                  },
                ),
                const Divider(), // Add a divider between each ListTile
              ],
            );
          },
        ),
      ),
    );
  }
}
