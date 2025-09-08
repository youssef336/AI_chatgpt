import 'package:ai_gpt/core/helper_functions/on_generate_routes.dart';
import 'package:ai_gpt/features/home/presentation/views/home_view.dart';
import 'package:ai_gpt/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AiGpt());
}

class AiGpt extends StatelessWidget {
  const AiGpt({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: HomeView.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
