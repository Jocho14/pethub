import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/onboarding/onboarding_provider.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/home/home_screen.dart'; 
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Set to false to disable in production
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => OnboardingProvider()),
          // Dodaj PostProvider, jeśli jest potrzebny
          // ChangeNotifierProvider(create: (_) => PostProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Zmieniamy tutaj na HomePage
      routes: {
        '/onboarding': (context) => OnboardingScreen(), // Dodaj trasę do OnboardingScreen
        // Dodaj inne trasy, jeśli są potrzebne
      },
    );
  }
}
