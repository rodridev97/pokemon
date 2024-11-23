import 'package:flutter/foundation.dart';

@immutable
class PokemonModel {
  final String? name;
  final String? url;

  const PokemonModel({
    this.name,
    this.url,
  });

  PokemonModel copyWith({
    String? name,
    String? url,
  }) =>
      PokemonModel(
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
