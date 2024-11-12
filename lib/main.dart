import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:device_preview/device_preview.dart';

import 'providers/onboarding/onboarding_provider.dart';
import 'providers/auth/auth_provider.dart';
import 'providers/message/message_provider.dart';

import 'screens/onboarding/onboarding_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/message/message_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    DevicePreview(
      enabled: true, // Set to false to disable in production
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => OnboardingProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => MessageProvider()),
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
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      return MaterialApp(
        title: 'Pet Hub',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: OnboardingScreen(),
        routes: {
          '/auth': (context) => LoginScreen(),
          '/home': (context) => HomePage(),
          '/chat': (context) => MessageScreen(
              otherUserId:
                  ModalRoute.of(context)?.settings.arguments as String),
        },
      );
    });
  }
}
