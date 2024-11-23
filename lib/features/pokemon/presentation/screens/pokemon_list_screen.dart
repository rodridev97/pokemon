import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:go_router/go_router.dart';
import '../bloc/pokemon_bloc.dart';
import 'pokemon_search_screen.dart';

class PokemonListScreen extends StatelessWidget {
  const PokemonListScreen({super.key});

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
              showSearch(context: context, delegate: PokemonSearchScreen());
            },
          ),
        ],
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.hasError) {
            return const Center(child: Text("Error loading Pokémon"));
          }

          // Ajusta la altura de las tarjetas según el tamaño del dispositivo
          final cardHeight = size.height * (size.width > 600 ? 0.5 : 0.35);

          return Swiper(
            itemCount: state.pokemons.length,
            itemWidth: size.width * (size.width > 600 ? 0.6 : 0.8),
            itemHeight: cardHeight,
            layout: SwiperLayout.STACK,
            itemBuilder: (context, index) {
              final pokemon = state.pokemons[index];
              return GestureDetector(
                onTap: () {
                  // Navegar a la pantalla de detalles
                  context.go('/details?url=${pokemon.url}');
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        pokemon.image,
                        height: cardHeight * 0.5,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        pokemon.name,
                        style: TextStyle(
                          fontSize: size.width > 600 ? 22 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
