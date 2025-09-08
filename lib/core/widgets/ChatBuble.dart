// ignore_for_file: file_names

import 'package:ai_gpt/constant_file.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(
          left: 12,
          top: 18,
          bottom: 18,
          right: 12,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: (kPrimaryColor),
        ),
        child: Text(message, style: const TextStyle(color: KWhiteColor)),
      ),
    );
  }
}

class ChatBubleForFreind extends StatelessWidget {
  const ChatBubleForFreind({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(
          left: 12,
          top: 18,
          bottom: 18,
          right: 12,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: (Color(0xff0671B1)),
        ),
        child: Text(message, style: const TextStyle(color: KWhiteColor)),
      ),
    );
  }
}
