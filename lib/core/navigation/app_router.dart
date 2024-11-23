import 'package:go_router/go_router.dart';

import '../../features/pokemon/pokemon.dart'
    show Pokemon, PokemonDetailScreen, PokemonListScreen;

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
          final url = (state.extra as Pokemon).url;
          return PokemonDetailScreen(url: url);
        },
      ),
    ],
  );
}
