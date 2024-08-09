import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/widgets/hoverable_image.dart';

class ProjectDetail extends StatelessWidget {
  final List<String> imageUrls;
  final String title;
  final String description;
  final List<String> skills;
  final VoidCallback onBack;

  const ProjectDetail({
    required this.imageUrls,
    required this.title,
    required this.description,
    required this.skills,
    required this.onBack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: onBack,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Web Development',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  title,
                  style: GoogleFonts.titilliumWeb(
                      fontSize: 45, color: Colors.black),
                ),
                const SizedBox(height: 25.0),
                Text(
                  description,
                  style: const TextStyle(fontSize: 18.0, color: Colors.black),
                ),
                const SizedBox(height: 40.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children:
                      skills.map((skill) => Chip(label: Text(skill))).toList(),
                ),
                // const SizedBox(height: 16.0),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HoverableImage(
                  imageUrl: imageUrls[0],
                  offset: const Offset(0, 0),
                ),
                const SizedBox(height: 20),
                HoverableImage(
                  imageUrl: imageUrls[1],
                  offset: const Offset(100, 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
