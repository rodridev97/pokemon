import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/pokemon_bloc.dart';

class PokemonSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Search Pokémon...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          // Vuelve a mostrar todos los Pokémon cuando el campo está vacío
          context.read<PokemonBloc>().add(SearchPokemon(query));
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
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        // Si estamos en estado de carga, mostramos un indicador de carga
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Si hay un error, mostramos un mensaje de error
        if (state.hasError) {
          return Center(child: Text(state.errorMessage ?? 'Error'));
        }

        // Si encontramos Pokémon que coinciden con la búsqueda
        final filteredPokemons = state.pokemons
            .where((pokemon) =>
                pokemon.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

        if (filteredPokemons.isEmpty) {
          return const Center(child: Text("No se encontraron Pokémon"));
        }

        return ListView.builder(
          itemCount: filteredPokemons.length,
          itemBuilder: (context, index) {
            final pokemon = filteredPokemons[index];
            return ListTile(
              title: Text(pokemon.name),
              leading: Image.network(pokemon.image),
              onTap: () {
                // Navegar a la pantalla de detalles
                context.push('/details?url=${pokemon.url}', extra: pokemon);
                context
                    .read<PokemonBloc>()
                    .add(FetchPokemonDetail(pokemon.url));
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        // Si estamos en estado de carga, mostramos un indicador de carga
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Si hay un error, mostramos un mensaje de error
        if (state.hasError) {
          return Center(child: Text(state.errorMessage ?? 'Error'));
        }

        // Filtramos los Pokémon mientras escribimos en el campo de búsqueda
        final filteredPokemons = state.pokemons
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
                // Navegar a la pantalla de detalles
                context.push('/details?url=${pokemon.url}', extra: pokemon);
                context
                    .read<PokemonBloc>()
                    .add(FetchPokemonDetail(pokemon.url));
              },
            );
          },
        );
      },
    );
  }
}
