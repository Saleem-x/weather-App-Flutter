import 'package:flutter/material.dart';
import 'package:note_app/constents/constents.dart';

class ClimateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final num value;

  const ClimateWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: size.height / 5,
        width: size.width / 3,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            icon,
            size: 50,
            color: kwhite,
          ),
          kheight20,
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          kheight20,
          Text(
            value.toString(),
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }
}
