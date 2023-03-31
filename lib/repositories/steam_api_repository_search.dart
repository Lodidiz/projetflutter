import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/game_search.dart';

class SteamApiSearch {
  static const String _storeBaseUrl = 'https://store.steampowered.com/api';

  Future<List<GameSearch>> searchGames(String searchTerm) async {
    try {
      final http.Response response = await http.get(
        Uri.parse('https://steamcommunity.com/actions/SearchApps/$searchTerm'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> searchResults = jsonDecode(response.body);
        final List<int> gameIds = searchResults
            .map<int>((dynamic game) => int.parse(game['appid'].toString()))
            .toList();

        if (kDebugMode) {
          print(gameIds);
        }

        if (gameIds == null) {
          throw Exception('Aucun jeu trouvé.');
        }

        List<GameSearch> games = <GameSearch>[];
        for (final int gameId in gameIds) {
          final Map<String, dynamic>? gameDetails =
              await fetchGameDetails(gameId);
          if (gameDetails != null) {
            games.add(GameSearch.fromJson(gameDetails));
          }
        }

        return games;
      } else {
        throw Exception(
            'Erreur lors de la récupération des résultats de recherche.');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
      throw Exception(
          'Erreur lors de la récupération des résultats de recherche.');
    }
  }

  Future<Map<String, dynamic>?> fetchGameDetails(int gameId) async {
    final http.Response response = await http.get(
      Uri.parse(
          //'$_storeBaseUrl/appdetails?appids=$gameId')
          '$_storeBaseUrl/appdetails?appids=$gameId'),
      headers: <String, String>{
        'x-requested-with': 'XMLHttpRequest',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('$gameId') && data['$gameId']['success']) {
        return data['$gameId']['data'];
      } else {
        return null;
      }
    } else {
      throw Exception('Erreur lors de la récupération des détails du jeu.');
    }
  }
}
