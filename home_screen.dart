import 'package:flutter/material.dart';
import 'your_account_page.dart';
import 'signup_page.dart';
import 'login_page.dart';
import 'notes_page.dart';
import 'research_page.dart';
import 'feedback_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isLoggedIn;

  const HomeScreen({super.key, this.isLoggedIn = false});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    isLoggedIn = widget.isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              _buildAboutSection(),
              const SizedBox(height: 20),
              _buildNotesSection(context),
              const SizedBox(height: 20),
              _buildResearchSection(context),
              const SizedBox(height: 20),
              _buildFeedbackSection(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 16, 201, 237),
            const Color.fromARGB(255, 171, 214, 237),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'assets/r.png',
                  height: 60,
                  width: 60,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "StudyMe",
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 11, 11),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          isLoggedIn
              ? IconButton(
                  icon: const Icon(Icons.account_circle, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const YourAccountPage(),
                      ),
                    );
                  },
                )
              : Row(
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.account_circle_rounded,
                        color: Colors.black,
                      ),
                      label: const Text("SignUp"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(10, 40),
                        foregroundColor: Colors.black,
                        backgroundColor:
                            const Color.fromARGB(255, 243, 245, 243),
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.login,
                        color: Colors.black,
                      ),
                      label: const Text("Login"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(10, 40),
                        foregroundColor: Colors.black,
                        backgroundColor:
                            const Color.fromARGB(255, 246, 246, 246),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/k.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha((0.4 * 255).toInt()),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "About Our App📚📝📒 🖊️",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "We offers computer science study materials, allowing students to share notes and collaborate efficiently. It also supports researchers in collecting timely data, making it a valuable tool for education and research.",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 209, 234, 234),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Notes are here📝💬",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "📤 Upload Notes Easily",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                SizedBox(height: 8),
                Text(
                  "📥 Download Study Resources",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                SizedBox(height: 8),
                Text(
                  "🔍 Search by Order",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                SizedBox(height: 8),
                Text(
                  "⏰🌐 Study Anytime, Anywhere",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                SizedBox(height: 8),
                Text(
                  "📝💬 Request More Notes: Comment below to ask for materials on any other topic.",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotesPage(),
                ),
              );
            },
            child: const Text(
              "Click Here 👉",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResearchSection(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 209, 234, 234),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Research Materials📖🔎",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Explore a curated collection of research materials designed to support your academic growth in computer science📋🔎. From foundational theories to cutting-edge innovations, these resources provide valuable insights, detailed analysis, and practical applications🔬📊. Whether you're working on assignments, preparing for exams, or advancing your research, these materials are crafted to inspire learning and innovation. Dive into the world of knowledge and take your understanding to the next level!",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResearchPage(),
                  ),
                );
              },
              child: const Text(
                "Click Here 👉",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 209, 234, 234),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/ert.jpg',
              fit: BoxFit.cover,
              height: 400,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Feedback💡",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "We value your feedback! Share your thoughts and rate our app with stars to help us improve and serve you better.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FeedbackScreen()),
                      );
                    },
                    child: const Text(
                      "Add your Feedback💡",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
