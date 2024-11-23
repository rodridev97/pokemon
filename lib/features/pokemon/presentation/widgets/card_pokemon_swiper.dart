import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../presentation.dart'
    show FetchPokemonDetail, PokemonBloc, PokemonState;

class CardSwiperPokemon extends StatelessWidget {
  const CardSwiperPokemon({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.hasError) {
          return Center(child: Text(state.errorMessage ?? "Ocurrió un error"));
        } else if (state.pokemons.isNotEmpty) {
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
                  context.push('/details?url=${pokemon.url}', extra: pokemon);
                  context
                      .read<PokemonBloc>()
                      .add(FetchPokemonDetail(pokemon.url));
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
        } else {
          return const Center(child: Text("No hay Pokémon disponibles"));
        }
      },
    );
  }
}
