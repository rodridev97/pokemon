import 'package:flutter/material.dart';

class PokemonDetailPage extends StatelessWidget {
  final String url;

  const PokemonDetailPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: isTablet ? 400.0 : 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Pokemon Name",
                style: TextStyle(fontSize: isTablet ? 24 : 18),
              ),
              background: Image.network(
                "https://via.placeholder.com/400",
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
                  DetailRow(label: "Height", value: "1.2m", isTablet: isTablet),
                  const SizedBox(height: 10),
                  DetailRow(label: "Weight", value: "40kg", isTablet: isTablet),
                  const SizedBox(height: 10),
                  Text(
                    "Abilities",
                    style: TextStyle(
                      fontSize: isTablet ? 24 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "- Ability 1\n- Ability 2",
                    style: TextStyle(fontSize: isTablet ? 20 : 16),
                  ),
                ],
              ),
            ),
          ),
        ],
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
