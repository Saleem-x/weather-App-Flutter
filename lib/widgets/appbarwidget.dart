import 'package:flutter/material.dart';
import 'package:note_app/constents/constents.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: kwhite,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.location_on,
            color: kwhite,
          ),
        ),
      ]),
    );
  }
}
