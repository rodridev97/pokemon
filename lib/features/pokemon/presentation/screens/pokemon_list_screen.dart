import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/pokemon_bloc.dart';
import '../widgets/card_pokemon_swiper.dart';
import '../widgets/pokemon_search_delegate.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PokemonBloc>().add(FetchPokemonList());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokémon List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: PokemonSearchDelegate());
            },
          ),
        ],
      ),
      body: CardSwiperPokemon(size: size),
    );
  }
}
