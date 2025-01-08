import 'package:flutter/material.dart';
import 'note_detail_page.dart';
import 'fileproses.dart';
import 'dart:io';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredNotes = [];

  @override
  void initState() {
    super.initState();
    _filteredNotes = notes;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterNotes(_searchController.text);
  }

  void _filterNotes(String query) {
    final filtered = notes.where((note) {
      final titleLower = note['title']!.toLowerCase();
      final subtitleLower = note['subtitle']!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          subtitleLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredNotes = filtered;
    });
  }

  void _addUploadedFile(int noteIndex, File file, String fileName) {
    setState(() {
      _filteredNotes[noteIndex]['pdfs'].add({
        'title': fileName,
        'filePath': file.path,
        'rating': 0.0,
      });
    });
  }

  void _navigateToFileUploadPage(int noteIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FileUploadPage(
          onFileUploaded: (file, fileName) {
            _addUploadedFile(noteIndex, file, fileName);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        backgroundColor: const Color.fromARGB(255, 150, 207, 237),
      ),
      body: Container(
        color: const Color.fromARGB(255, 209, 234, 234),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Notes 📚",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Notes',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredNotes.length,
                itemBuilder: (context, index) {
                  final note = _filteredNotes[index];
                  return _buildNoteTile(
                    context,
                    title: note['title']!,
                    subtitle: note['subtitle']!,
                    pdfs: note['pdfs']!,
                    noteIndex: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildNoteTile(BuildContext context,
      {required String title,
      required String subtitle,
      required List<Map<String, dynamic>> pdfs,
      required int noteIndex}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.note),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                  fontSize: 12, color: Color.fromARGB(255, 35, 31, 31)),
            ),
            const SizedBox(height: 8),
            ...pdfs.map((pdf) => _buildPdfTile(pdf)),
            const SizedBox(height: 8),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteDetailPage(
                noteTitle: title,
                pdfFiles: pdfs,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPdfTile(Map<String, dynamic> pdf) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(pdf['title']),
      ],
    );
  }
}

final List<Map<String, dynamic>> notes = [
  {
    'title': 'Introduction to Computer Science',
    'subtitle':
        'Includes📝💬: What is Computer Science?, History and evolution of computers, etc.',
    'pdfs': [
      {
        'title': 'Intr.pdf',
        'filePath': 'assets/pdfs/w.pdf',
        'rating': 0.0, // Initial rating
      },
      {'title': 'IntroCS2.pdf', 'filePath': 'assets/pdfs/inpdf', 'rating': 0.0},
    ],
  },
  {
    'title': 'Programming Fundamentals',
    'subtitle':
        'Includes📝💬: Programming languages (C, Java, Python, etc.), Control structures, etc.',
    'pdfs': [
      {
        'title': 'ProgFund1.pdf',
        'filePath': 'assets/pdfs/212.pdf',
        'rating': 0.0
      },
    ],
  },
];
