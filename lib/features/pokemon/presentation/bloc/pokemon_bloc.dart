import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/domain.dart'
    show Pokemon, PokemonDetails, PokemonRepository;

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository repository = PokemonRepository.repo;

  PokemonBloc() : super(PokemonState.initial()) {
    on<FetchPokemonList>(_onFetchPokemonList);
    on<FetchPokemonDetail>(_onFetchPokemonDetail);
  }

  /// Lógica para obtener la lista de Pokémon.
  // Función para manejar el evento de cargar la lista de Pokémon
  Future<void> _onFetchPokemonList(
      FetchPokemonList event, Emitter<PokemonState> emit) async {
    emit(state.copyWith(isLoading: true, hasError: false));

    try {
      final pokemons = await repository.fetchPokemons();
      emit(state.copyWith(isLoading: false, pokemons: pokemons));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: "Error al cargar los Pokémon: $e",
      ));
    }
  }

  // Función para manejar el evento de cargar los detalles de un Pokémon
  Future<void> _onFetchPokemonDetail(
      FetchPokemonDetail event, Emitter<PokemonState> emit) async {
    emit(state.copyWith(isLoading: true, hasError: false));

    try {
      final pokemonDetails = await repository.fetchPokemonDetails(event.url);
      emit(state.copyWith(
        isLoading: false,
        selectedPokemonDetails: pokemonDetails,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: "Error al cargar los detalles: $e",
      ));
    }
  }
}