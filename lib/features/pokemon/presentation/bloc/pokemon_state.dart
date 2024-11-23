part of 'pokemon_bloc.dart';

class PokemonState extends Equatable {
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final List<Pokemon> pokemons;
  final PokemonDetails? selectedPokemonDetails;

  const PokemonState({
    required this.isLoading,
    required this.hasError,
    required this.errorMessage,
    required this.pokemons,
    required this.selectedPokemonDetails,
  });

  // Estado inicial
  factory PokemonState.initial() {
    return const PokemonState(
      isLoading: false,
      hasError: false,
      errorMessage: null,
      pokemons: [],
      selectedPokemonDetails: null,
    );
  }

  // Copiar con nuevos valores
  PokemonState copyWith({
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    List<Pokemon>? pokemons,
    PokemonDetails? selectedPokemonDetails,
  }) {
    return PokemonState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      pokemons: pokemons ?? this.pokemons,
      selectedPokemonDetails:
          selectedPokemonDetails ?? this.selectedPokemonDetails,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, hasError, errorMessage, pokemons, selectedPokemonDetails];
}
