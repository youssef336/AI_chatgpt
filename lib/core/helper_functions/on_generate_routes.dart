import 'package:ai_gpt/features/home/presentation/views/Ai_view.dart';
import 'package:ai_gpt/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case AiView.routeName:
      return MaterialPageRoute(builder: (_) => const AiView());

    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text('404 Not Found'))),
      );
  }
}
