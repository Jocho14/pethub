import 'package:flutter/material.dart';

import 'package:pethub/models/onboarding/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingPageModel pageModel;

  const OnboardingPage({required this.pageModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            pageModel.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            pageModel.summary,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          Image.asset(
            pageModel.image,
            height: 350,
          ),
        ],
      ),
    );
  }
}
