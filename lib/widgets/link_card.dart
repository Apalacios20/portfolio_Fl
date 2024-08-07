// AP20 POSSIBLY DELETE
import 'package:flutter/material.dart';

class LinkCard extends StatelessWidget {
  final ImageProvider<Object> image;
  final String? title;

  const LinkCard({Key? key, required this.image, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO: make size dynamic
      width: 240,
      height: 350,
      decoration: BoxDecoration(
        image: DecorationImage(image: image, fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 25),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
        color: Colors.black,
      ),
      child: ClipRRect(
        child: Stack(
          children: [
            Positioned.fill(
                child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
