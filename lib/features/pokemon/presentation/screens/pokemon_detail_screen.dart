import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pokemon.dart' show PokemonBloc, PokemonState;

class PokemonDetailScreen extends StatefulWidget {
  final String url;

  const PokemonDetailScreen({super.key, required this.url});

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.hasError) {
            return const Center(child: Text("Error loading details"));
          }

          final pokemon = state.selectedPokemonDetails;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text(
                  "Pokemon Details",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                expandedHeight: isTablet ? 400.0 : 300.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "${pokemon?.name}",
                    style: TextStyle(
                      fontSize: isTablet ? 24 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  background: Image.network(
                    pokemon?.urlImage ?? "https//via.placeholder.com/400",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 32.0 : 16.0,
                  vertical: 16.0,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text(
                        "Details",
                        style: TextStyle(
                          fontSize: isTablet ? 28 : 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      DetailRow(
                          label: "Height",
                          value: "${pokemon?.height}m",
                          isTablet: isTablet),
                      const SizedBox(height: 10),
                      DetailRow(
                          label: "Weight",
                          value: "${pokemon?.weight}kg",
                          isTablet: isTablet),
                      const SizedBox(height: 10),
                      const Divider(),
                      Text(
                        "Abilities",
                        style: TextStyle(
                          fontSize: isTablet ? 24 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: pokemon?.abilities
                                .map((ability) => Text(
                                      "- $ability",
                                      style: TextStyle(
                                          fontSize: isTablet ? 20 : 16),
                                    ))
                                .toList() ??
                            [],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTablet;

  const DetailRow({
    Key? key,
    required this.label,
    required this.value,
    required this.isTablet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: isTablet ? 20 : 16, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(fontSize: isTablet ? 20 : 16),
        ),
      ],
    );
  }
}
