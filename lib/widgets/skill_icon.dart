import 'package:flutter/material.dart';

class SkillIcon extends StatelessWidget {
  final ImageProvider<Object> image;
  const SkillIcon({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(
                0.5), // Change the color and opacity of the shadow as needed
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes the position of the shadow
          ),
        ],
        image: DecorationImage(
          image: image, // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
