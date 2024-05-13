import 'package:flutter/material.dart';

class IconsBackground extends StatelessWidget {
  final IconData iconData;
  final String text;

  const IconsBackground({Key? key, required this.iconData, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerSize = MediaQuery.of(context).size.width * 0.11;

    return Column(
      children: [
        Container(
          width: containerSize,
          height: containerSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xff290059),
            borderRadius: BorderRadius.circular(containerSize / 2),
          ),
          child: Icon(
            iconData,
            size: containerSize * 0.8,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8), // Added some spacing between icon and text
        Text(
          text,
          style: const TextStyle(color: Colors.black,fontSize: 12,),
        ),
      ],
    );
  }
}
