import '../../data/data.dart' show PokemonRemoteDataSource;
import '../domain.dart' show Pokemon, PokemonDetails;

class PokemonRepository {
  PokemonRepository._(this.dataSource);

  static final repo = PokemonRepository._(PokemonRemoteDataSource.instance);
  final PokemonRemoteDataSource dataSource;

  PokemonRepository(this.dataSource);

  // Obtiene y convierte una lista de Pokémon
  Future<List<Pokemon>> fetchPokemons() async {
    try {
      final pokemonModels = await dataSource.fetchPokemonList();

      // Convertir de PokemonModel a Pokemon
      return pokemonModels.map((model) {
        final id =
            model.url?.split('/').where((segment) => segment.isNotEmpty).last;

        return Pokemon(
          name: model.name ?? '',
          url: model.url ?? '',
          image:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
        );
      }).toList();
    } catch (e) {
      throw Exception("Error al obtener los Pokémon: $e");
    }
  }

  // Obtiene y convierte los detalles de un Pokémon
  Future<PokemonDetails> fetchPokemonDetails(String url) async {
    try {
      final detailModel = await dataSource.fetchPokemonDetails(url);

      // Convertir de PokemonDetailModel a PokemonDetails
      return PokemonDetails(
        name: detailModel.name ?? '',
        height: double.parse(detailModel.height.toString()),
        weight: double.parse(detailModel.weight.toString()),
        abilities: detailModel.abilities
                ?.map((ability) => ability.ability?.name ?? '')
                .toList() ??
            [],
        urlImage:
            detailModel.sprites?.other?.officialArtwork?.frontDefault ?? '',
      );
    } catch (e) {
      throw Exception("Error al obtener los detalles del Pokémon: $e");
    }
  }
}
