// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:recipes/constance.dart';

class TextRow extends StatelessWidget {
  final String text;
  final String tapText;
  final Function() onTap;

  const TextRow(
      {super.key,
      required this.text,
      required this.onTap,
      required this.tapText});

  @override
  Widget build(BuildContext context) {
    final constants = Constans(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 10 ,),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: GestureDetector(
            onTap: () {
              onTap();
            },
            child: Text(
              tapText,
              style: TextStyle(
                color: constants.brown,
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    );
  }
}
