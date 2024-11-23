import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/pokemon_bloc.dart';

class PokemonSearchScreen extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final pokemonBloc = context.read<PokemonBloc>();
    final filteredPokemons = pokemonBloc.state.pokemons
        .where((pokemon) =>
            pokemon.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredPokemons.length,
      itemBuilder: (context, index) {
        final pokemon = filteredPokemons[index];
        return ListTile(
          title: Text(pokemon.name),
          leading: Image.network(pokemon.image),
          onTap: () {
            close(context, null);
            context.go('/details?url=${pokemon.url}');
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text("Type to search Pokémon"),
    );
  }
}
