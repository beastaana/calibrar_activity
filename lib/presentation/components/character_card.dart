import 'package:calibrar_activity/logic/model/character_model.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            character.image,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            character.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}