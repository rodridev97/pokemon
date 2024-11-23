import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core.dart' show AppRouter;
import 'features/pokemon/pokemon.dart' show PokemonBloc;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PokemonBloc(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'Pokemon App Test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.purple.shade100,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.purple.shade300,
          ),
          colorSchemeSeed: Colors.purple,
          useMaterial3: true,
        ),
      ),
    );
  }
}
