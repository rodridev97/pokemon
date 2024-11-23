import 'package:flutter/foundation.dart';

@immutable
class PokemonDetails {
  final String name;
  final double height;
  final double weight;
  final List<String> abilities;

  const PokemonDetails({
    required this.name,
    required this.height,
    required this.weight,
    required this.abilities,
  });

  // Factory constructor para mapear desde datos de la API
  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    final abilities = (json['abilities'] as List)
        .map((ability) => ability['ability']['name'] as String)
        .toList();

    return PokemonDetails(
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      abilities: abilities,
    );
  }
}
