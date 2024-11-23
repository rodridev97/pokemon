part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

@immutable
class FetchPokemonList extends PokemonEvent {}

@immutable
class FetchPokemonDetail extends PokemonEvent {
  final String url;

  FetchPokemonDetail(this.url);
}

class SearchPokemon extends PokemonEvent {
  final String query;

  SearchPokemon(this.query);

  @override
  List<Object> get props => [query];
}
