import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/onboarding/onboarding_provider.dart';
import 'screens/onboarding/onboarding_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnboardingScreen(),
      routes: {
        //'/home': (context) => HomeScreen(),
      },
    );
  }
}
