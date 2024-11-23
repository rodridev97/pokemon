part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

@immutable
sealed class FetchPokemonList extends PokemonEvent {}

@immutable
sealed class FetchPokemonDetail extends PokemonEvent {
  final String url;

  FetchPokemonDetail(this.url);
}
