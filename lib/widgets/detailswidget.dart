import 'package:flutter/material.dart';
import 'package:note_app/constents/constents.dart';

class DetailsWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const DetailsWidget({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: kwhite,
          ),
          kheight10,
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
