// ignore_for_file: file_names

import 'package:ai_gpt/features/home/presentation/views/widgets/Ai_view_body.dart';
import 'package:flutter/material.dart';

class AiView extends StatelessWidget {
  const AiView({super.key});
  static const routeName = '/ai';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AiChatScreen());
  }
}
