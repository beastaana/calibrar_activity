import 'package:calibrar_activity/logic/model/character_model.dart';
import 'package:calibrar_activity/presentation/components/character_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CharacterGrid extends StatefulWidget {
  const CharacterGrid({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CharacterGridState createState() => _CharacterGridState();
}

class _CharacterGridState extends State<CharacterGrid> {
  List<CharacterModel> characters = [];

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<CharacterModel> fetchedCharacters = (data['results'] as List)
          .map((characterData) => CharacterModel.fromJson(characterData))
          .toList();

      setState(() {
        characters = fetchedCharacters;
      });
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: characters.length,
            itemBuilder: (context, index) {
              return CharacterCard(character: characters[index]);
            },
          );
  }
}