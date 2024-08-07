import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/pages/controller.dart';
import 'package:myportfolio/widgets/skill_icon.dart';

class ProjectsAndSkillsView extends StatefulWidget {
  final MainController controller;
  const ProjectsAndSkillsView({required this.controller, super.key});

  @override
  State<ProjectsAndSkillsView> createState() => _ProjectsAndSkillsViewState();
}

class _ProjectsAndSkillsViewState extends State<ProjectsAndSkillsView> {
  bool _isCardSelected = false;
  String? _selectedImageUrl;
  String? _selectedTitle;
  String? _selectedDescription;
  List<String>? _selectedSkills;

  void _selectCard(
      String imageUrl, String title, String description, List<String> skills) {
    setState(() {
      _isCardSelected = true;
      _selectedImageUrl = imageUrl;
      _selectedTitle = title;
      _selectedDescription = description;
      _selectedSkills = skills;
    });
  }

  void _deselectCard() {
    setState(() {
      _isCardSelected = false;
      _selectedImageUrl = null;
      _selectedTitle = null;
      _selectedDescription = null;
      _selectedSkills = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
        padding: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.height / 15, 0, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Work History",
                style:
                    GoogleFonts.titilliumWeb(fontSize: 35, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            const JobTileWidget(
              positionHeldAtCompany: 'Flutter and NestJS Developer @ Tether RE',
              yearsWorkedAtCo: '2023 - Present',
              jobLocation: 'Twin Falls, Idaho',
              jobWebsite: 'tetherre.com',
              jobDescription:
                  'Developing a real estate application designed to enhance the safety of real estate agents. Responsible for complex implementations, including SQS, background services, and integrations, always prioritizing reliability and enhancing user interaction.',
              skills: [
                'Flutter',
                'React',
                'JavaScript',
                'Nest.js',
                'Postgresql',
                'AWS'
              ],
              imageName: "TetherRE.png",
            ),
            const JobTileWidget(
              positionHeldAtCompany:
                  'Jr. Flutter Developer / Data Analyst @ ThirtyThree',
              yearsWorkedAtCo: '2022 - 2023',
              jobLocation: 'Yorba Linda, California',
              jobWebsite: null,
              jobDescription:
                  'Developed and maintained an application aimed at modernizing the cell tower surveying process, replacing traditional pen-and-paper methods to prioritize efficiency, dependability, and data accuracy.',
              skills: ['React', 'JavaScript', 'Nest.js', 'Postgresql'],
              imageName: "tangent.png",
            ),
            const SizedBox(
              height: 45,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Projects",
                style:
                    GoogleFonts.titilliumWeb(fontSize: 35, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            // AP20 tile cards
            // i think this is where im suppose to set state and remove widgets and render other layout
            if (_isCardSelected)
              Align(
                alignment: Alignment.centerLeft,
                child: ProjectDetail(
                  imageUrl: _selectedImageUrl!,
                  title: _selectedTitle!,
                  description: _selectedDescription!,
                  skills: _selectedSkills!,
                  onBack: _deselectCard,
                ),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TileCard(
                    imageUrl: "python.png",
                    title: "Crypto Exchange UI",
                    description: "Web Development",
                    onTap: () => _selectCard(
                        "assets/python.png",
                        "Crypto Exchange UI",
                        "Detailed description of Crypto Exchange UI project...",
                        ["Flutter", "React", "JavaScript"]),
                  ),
                  TileCard(
                    imageUrl: "flare.svg",
                    title: "Flare Network API",
                    description: "Web Development",
                    onTap: () => _selectCard(
                        "assets/flare.svg",
                        "Flare Network API",
                        "Detailed description of Flare Network API project...",
                        ["Flutter", "React", "JavaScript"]),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class JobTileWidget extends StatefulWidget {
  final String positionHeldAtCompany;
  final String yearsWorkedAtCo;
  final String jobLocation;
  final String? jobWebsite;
  final String jobDescription;
  final List<String> skills;
  final String imageName;

  const JobTileWidget({
    required this.positionHeldAtCompany,
    required this.yearsWorkedAtCo,
    required this.jobLocation,
    this.jobWebsite,
    required this.jobDescription,
    required this.skills,
    required this.imageName,
    super.key,
  });

  @override
  State<JobTileWidget> createState() => _JobTileWidgetState();
}

class _JobTileWidgetState extends State<JobTileWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  RxBool isDetailVisible = false.obs;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
  }

  void toggleDetails() {
    if (isDetailVisible.value) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    isDetailVisible.value = !isDetailVisible.value;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey[600],
              borderRadius: BorderRadius.circular(12.0),
              // AP20 new
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 1, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.positionHeldAtCompany,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Text(
                  widget.yearsWorkedAtCo,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                  icon: Icon(
                    isDetailVisible.value ? Icons.clear : Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: toggleDetails,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 155.0),
            child: SizeTransition(
              sizeFactor: _animation,
              axisAlignment: -1.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: MediaQuery.of(context).size.width / 2,
                padding: isDetailVisible.value
                    ? const EdgeInsets.all(16.0)
                    : EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: isDetailVisible.value
                      ? Colors.orange[800]!.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: isDetailVisible.value
                    ? JobContent(
                        jobLocation: widget.jobLocation,
                        jobWebsite: widget.jobWebsite,
                        jobDescription: widget.jobDescription,
                        skills: widget.skills,
                        imageName: widget.imageName,
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JobContent extends StatelessWidget {
  final String jobLocation;
  final String? jobWebsite;
  final String jobDescription;
  final List<String> skills;
  final String imageName;

  const JobContent({
    required this.jobLocation,
    this.jobWebsite,
    required this.jobDescription,
    required this.skills,
    required this.imageName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on_sharp),
                  const SizedBox(width: 10),
                  Text(
                    jobLocation,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(width: 30),
                  if (jobWebsite != null && jobWebsite!.isNotEmpty) ...[
                    const Icon(Icons.blur_on),
                    const SizedBox(width: 10),
                    Text(
                      jobWebsite!,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  jobDescription,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: skills.map((skill) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: SkillNullBtn(text: skill),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Image.asset("assets/$imageName"),
        ),
      ],
    );
  }
}

class SkillNullBtn extends StatelessWidget {
  final String text;
  const SkillNullBtn({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.7),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15.0,
        ),
      ),
    );
  }
}

class TileCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onTap;

  const TileCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _TileCardState createState() => _TileCardState();
}

class _TileCardState extends State<TileCard> {
  bool isHovered = false;

  bool isSvg(String imageUrl) {
    return imageUrl.toLowerCase().endsWith('.svg');
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        child: SizedBox(
          width: 300,
          height: 375,
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12.0)),
                  child: AnimatedScale(
                    scale: isHovered ? 1.1 : 1.0,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: isSvg(widget.imageUrl)
                        ? Container(
                            padding: EdgeInsets.all(35),
                            color: Colors.white,
                            width: double.infinity,
                            height: 260,
                            child: SvgPicture.asset(
                              'assets/${widget.imageUrl}',
                              width: double.infinity,
                              height: 260,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Image.asset(
                            widget.imageUrl,
                            width: double.infinity,
                            height: 260,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Text(
                            isHovered ? "Details" : widget.description,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (isHovered) ...[
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 25,
                            )
                          ]
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectDetail extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final List<String> skills;
  final VoidCallback onBack;

  const ProjectDetail({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.skills,
    required this.onBack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: onBack,
          ),
          Text(
            title,
            style: GoogleFonts.titilliumWeb(fontSize: 35, color: Colors.black),
          ),
          const SizedBox(height: 16.0),
          Text(
            description,
            style: const TextStyle(fontSize: 18.0, color: Colors.black),
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: skills.map((skill) => Chip(label: Text(skill))).toList(),
          ),
          const SizedBox(height: 16.0),
          if (imageUrl.toLowerCase().endsWith('.svg'))
            SvgPicture.asset(
              imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.contain,
            )
          else
            Image.asset(
              imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.contain,
            ),
        ],
      ),
    );
  }
}
