import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pdf_viewer_page.dart';

class ResearchPage extends StatefulWidget {
  const ResearchPage({super.key});

  @override
  _ResearchPageState createState() => _ResearchPageState();
}

class _ResearchPageState extends State<ResearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _pdfs = [
    {'title': 'How to Do Research', 'filePath': 'assets/pdfs/in.pdf'},
    {'title': 'Topics to Learn', 'filePath': 'assets/pdfs/ku.pdf'},
  ];
  List<Map<String, String>> _filteredPdfs = [];
  final List<Map<String, String>> _sitesToVisit = [
    {'name': 'arXiv', 'url': 'https://arxiv.org/'},
    {'name': 'fore', 'url': 'https://example.com'},
  ];

  @override
  void initState() {
    super.initState();
    _filteredPdfs = _pdfs;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredPdfs = _pdfs.where((pdf) {
        final titleLower = pdf['title']!.toLowerCase();
        final searchLower = _searchController.text.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Research Page'),
        backgroundColor: const Color.fromARGB(255, 150, 207, 237),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'PDFs:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredPdfs.length,
              itemBuilder: (context, index) {
                final pdf = _filteredPdfs[index];
                return ListTile(
                  leading: const Icon(Icons.picture_as_pdf),
                  title: Text(pdf['title']!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PDFViewerPage(filePath: pdf['filePath']!),
                      ),
                    );
                  },
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Sites to Visit:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _sitesToVisit.length,
              itemBuilder: (context, index) {
                final site = _sitesToVisit[index];
                return ListTile(
                  leading: const Icon(Icons.link),
                  title: Text(site['name']!),
                  onTap: () => _launchURL(site['url']!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
