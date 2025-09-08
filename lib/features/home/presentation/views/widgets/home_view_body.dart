import 'package:ai_gpt/core/widgets/custom_buttom.dart';
import 'package:ai_gpt/features/home/presentation/views/Ai_view.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButtom(
            text: 'Next >',
            onPressed: () {
              Navigator.pushNamed(context, AiView.routeName);
            },
          ),
        ],
      ),
    );
  }
}
