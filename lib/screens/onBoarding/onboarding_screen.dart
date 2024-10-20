import 'package:flutter/material.dart';
import '../../models/onboarding/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Using the OnboardingPageModel object
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
    ),
  ];

  void _goToNextPage() {
    if (_currentPage < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _skipToLastPage() {
    _pageController.animateToPage(
      onboardingPages.length - 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _skipToLastPage,
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: onboardingPages.length,
        itemBuilder: (context, index) {
          return OnboardingPage(
            pageModel: onboardingPages[index], // Pass custom model
          );
        },
      ),
      bottomSheet: _currentPage == onboardingPages.length - 1
          ? _buildGetStartedButton()
          : _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: _goToNextPage,
            child: Text(
              'Next',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the next screen after onboarding
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: Text(
            'Get Started',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
          ),
        ),
      ),
    );
  }
}

// Individual Onboarding Page widget
class OnboardingPage extends StatelessWidget {
  final OnboardingPageModel pageModel;

  const OnboardingPage({
    required this.pageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Text(
            pageModel.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),

          // Summary
          Text(
            pageModel.summary,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),

          // Image
          Image.asset(
            pageModel.image,
            height: 300,
          ),
        ],
      ),
    );
  }
}
