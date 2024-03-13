import 'package:flutter/material.dart';

class ListInfoWidget extends StatelessWidget {
  final String title;
  final String content;
  final String subtitle;

  const ListInfoWidget(
      {super.key,
      required this.title,
      required this.content,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 14,
            top: 12,
            bottom: 8,
            right: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /*
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              */
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 14,
            top: 12,
            bottom: 8,
            right: 14,
          ),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  content,
                  //overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 14,
            top: 12,
            bottom: 8,
            right: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                subtitle,
                style: const TextStyle(color: Color(0xffAFB6C8)),
              ))
            ],
          ),
        ),
      ],
    );
  }
}
