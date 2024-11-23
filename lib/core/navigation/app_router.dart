import 'package:go_router/go_router.dart';

import '../../features/pokemon/pokemon.dart'
    show PokemonListScreen, PokemonDetailPage;

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const PokemonListScreen(),
      ),
      GoRoute(
        path: '/details',
        builder: (context, state) {
          final url = state.pathParameters['url']!;
          return PokemonDetailPage(url: url);
        },
      ),
    ],
  );
}
