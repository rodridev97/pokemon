import 'package:flutter/foundation.dart';

@immutable
class Pokemon {
  final String name;
  final String image;
  final String url;

  const Pokemon({
    required this.name,
    required this.image,
    required this.url,
  });

  // Factory constructor para mapear desde datos de la API
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final url = json['url'];
    final id = url.split('/').where((segment) => segment.isNotEmpty).last;

    return Pokemon(
      name: name,
      url: url,
      image:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
    );
  }
}
