import 'package:flutter/material.dart';
import 'package:pethub/models/onboarding/onboarding_model.dart';

class OnboardingProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentPage = 0;

  final List<OnboardingPageModel> onboardingPages = [
    OnboardingPageModel(
      title: 'Easily Find Pet Care.',
      summary: 'Connect with trusted pet sitters nearby.',
      image: 'assets/images/onboarding_1.png',
    ),
    OnboardingPageModel(
      title: 'Help Others with Their Pets.',
      summary: 'Take care of pets when their owners need help.',
      image: 'assets/images/onboarding_2.png',
    ),
    OnboardingPageModel(
      title: 'Track Requests Seamlessly.',
      summary: 'Easily manage your requests and offers to help.',
      image: 'assets/images/onboarding_3.png',
    ),
    OnboardingPageModel(
      title: 'Get Started Now!',
      summary: 'Sign up today to find the perfect care for your pets.',
      image: 'assets/images/onboarding_4.png',
    )
  ];

  void goToNextPage() {
    if (currentPage < onboardingPages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void skipToLastPage() {
    pageController.animateToPage(
      onboardingPages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void onPageChanged(int index) {
    currentPage = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
