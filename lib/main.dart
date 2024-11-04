import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'providers/onboarding/onboarding_provider.dart';
import 'providers/auth/auth_provider.dart';

import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(milliseconds: 100));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return MaterialApp(
          title: 'Pet Hub',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: OnboardingScreen(),
          routes: {
            '/auth': (context) => LoginScreen(),
          },
        );
      },
    );
  }
}
