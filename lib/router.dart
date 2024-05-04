import 'package:go_router/go_router.dart';
import 'package:workout_diary/main.dart';

GoRouter goRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
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
