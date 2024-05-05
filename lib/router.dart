import 'package:go_router/go_router.dart';
import 'package:workout_diary/main.dart';
import 'package:workout_diary/views/onboarding/splash_page.dart';

GoRouter goRouter() {
  return GoRouter(
    initialLocation: '/splash_page',
    routes: [
      GoRoute(
        path: '/splash_page',
        name: 'splash_page',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) {
          return const MyHomePage(title: 'Workout Diary');
        },
      )
    ],
  );
}
