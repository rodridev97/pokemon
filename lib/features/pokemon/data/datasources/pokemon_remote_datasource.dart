import '../../../../core/core.dart' show DioClient, Strings;
import '../models/pokemon_detail_model.dart';
import '../models/pokemon_model.dart';

class PokemonRemoteDataSource {
  PokemonRemoteDataSource._();

  static final instance = PokemonRemoteDataSource._();

  // Función para obtener la lista de Pokémon
  Future<List<PokemonModel>> fetchPokemonList() async {
    try {
      final response =
          await DioClient.dio.get('${Strings.baseUrl}${Strings.pokemon}');

      // Verificar si la respuesta es exitosa
      if (response.statusCode == 200) {
        // Parsear la respuesta y obtener la lista de Pokémon
        final List pokemonData = response.data['results'];
        return pokemonData.map((data) => PokemonModel.fromJson(data)).toList();
      } else {
        throw Exception(
            'Error en la respuesta de la API: ${response.statusCode}');
      }
    } catch (e) {
      // Captura cualquier error, como problemas de red o de parsing
      throw Exception('Error al obtener la lista de Pokémon: $e');
    }
  }

  // Función para obtener los detalles de un Pokémon
  Future<PokemonDetailModel> fetchPokemonDetails(String url) async {
    try {
      final response = await DioClient.dio.get(url);

      // Verificar si la respuesta es exitosa
      if (response.statusCode == 200) {
        // Parsear la respuesta y obtener los detalles del Pokémon
        return PokemonDetailModel.fromJson(response.data);
      } else {
        throw Exception(
            'Error en la respuesta de la API: ${response.statusCode}');
      }
    } catch (e) {
      // Captura cualquier error, como problemas de red o de parsing
      throw Exception('Error al obtener los detalles del Pokémon: $e');
    }
  }
}
