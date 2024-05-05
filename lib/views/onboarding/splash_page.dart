import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_diary/views/onboarding/onboarding_content.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with AfterLayoutMixin<SplashPage> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      goToHome();
    } else {
      await prefs.setBool('seen', true);
    }
  }

  void goToHome() {
    context.pushReplacement('/');
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  int currentIndex = 0;
  final List<OnboardingContent> onboardingContents = [
    const OnboardingContent(
      title: 'Flexible',
      subtitle: 'Create workouts and exercises as per your need',
      imagePath: 'assets/workout.jpg',
    ),
    const OnboardingContent(
      title: 'Easy to use',
      subtitle: 'Just a digital diary for your daily workout',
      imagePath: 'assets/calender.jpg',
    ),
    const OnboardingContent(
      title: 'Insightful',
      subtitle:
          'Spot patterns and trends in your training through charts and set new goals',
      imagePath: 'assets/chart.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 500,
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: onboardingContents.length,
              itemBuilder: (context, index) {
                return OnboardingPage(
                    title: onboardingContents[index].title,
                    subtitle: onboardingContents[index].subtitle,
                    imagePath: onboardingContents[index].imagePath);
              },
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingContents.length,
              (index) => Padding(
                padding: const EdgeInsets.only(
                  right: 4,
                ),
                child: AnimatedDot(isActive: index == currentIndex),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            ),
            child: const Text(
              "GET STARTED",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class AnimatedDot extends StatelessWidget {
  const AnimatedDot({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 20 : 6,
      decoration: BoxDecoration(
        color:
            isActive ? Colors.black : const Color(0xFF868686).withOpacity(0.25),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12,
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  final String title, subtitle, imagePath;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(imagePath),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: 350,
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
