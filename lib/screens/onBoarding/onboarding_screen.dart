import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';

import 'package:pethub/providers/onboarding/onboarding_provider.dart';
import 'package:pethub/widgets/onboarding/onboarding_page_widget.dart';
import 'package:pethub/styles/variables.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onboardingProvider = Provider.of<OnboardingProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: onboardingProvider.pageController,
              onPageChanged: onboardingProvider.onPageChanged,
              itemCount: onboardingProvider.onboardingPages.length,
              itemBuilder: (context, index) {
                return OnboardingPage(
                  pageModel: onboardingProvider.onboardingPages[index],
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: onboardingProvider.pageController,
            count: onboardingProvider.onboardingPages.length,
            effect: WormEffect(
              activeDotColor: AppColors.accent,
              dotColor: const Color(0xFFCFCFCF),
              dotHeight: 8.0,
              dotWidth: 8.0,
              spacing: 10.0,
            ),
          ),
          SizedBox(height: 20),
          onboardingProvider.currentPage ==
                  onboardingProvider.onboardingPages.length - 1
              ? _buildGetStartedButton(context)
              : _buildBottomNavigation(context, onboardingProvider),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(
      BuildContext context, OnboardingProvider onboardingProvider) {
    return Container(
      height: 120,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: onboardingProvider.goToNextPage,
            child: Text(
              'Next',
              style: TextStyle(
                color: AppColors.white,
                fontSize: AppFonts.sizeLarge,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              fixedSize: Size(170, 40),
            ),
          ),
          TextButton(
            onPressed: onboardingProvider.skipToLastPage,
            child: Text(
              'Skip',
              style: TextStyle(
                color: AppColors.black,
                fontSize: AppFonts.sizeLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: Text(
            'Get Started',
            style: TextStyle(
              color: AppColors.black,
              fontSize: AppFonts.sizeLarge,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
          ),
        ),
      ),
    );
  }
}
