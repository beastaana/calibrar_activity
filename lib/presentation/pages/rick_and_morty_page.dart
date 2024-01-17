import 'package:calibrar_activity/logic/model/character_model.dart';
import 'package:calibrar_activity/presentation/components/character_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RickAndMortyPage extends StatefulWidget {
  const RickAndMortyPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RickAndMortyPageState createState() => _RickAndMortyPageState();
}

class _RickAndMortyPageState extends State<RickAndMortyPage> {
  late List<CharacterModel> characters;

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    const String baseURL = "https://rickandmortyapi.com/api/character";
    final response =
        await http.get(Uri.parse(baseURL));

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
    return _buildCharacterList();
  }

  Widget _buildCharacterList() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Use GridView for web
          return _buildGridView();
        } else {
          // Use ListView for mobile
          return _buildListView();
        }
      },
    );
  }

  Widget _buildGridView() {
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

  Widget _buildListView() {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        return CharacterCard(character: characters[index]);
      },
    );
  }
}
