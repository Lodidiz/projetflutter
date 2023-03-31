import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:projet/models/game.dart';

class SteamApiRepository {
  static const String _baseUrl = 'https://api.steampowered.com';
  static const String _storeBaseUrl = 'https://store.steampowered.com/api';

  Future<List<Game>> fetchMostPlayedGames() async {
    try {
      final http.Response response = await http.get(
        Uri.parse(
            '$_baseUrl/ISteamChartsService/GetMostPlayedGames/v1/'),
        //'$_baseUrl/ISteamChartsService/GetMostPlayedGames/v1/'),
        headers: <String, String>{
          'x-requested-with': 'XMLHttpRequest',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        //if (kDebugMode) {
        //  print(data); affiche la meme que rankdatalist
        //}
        // Récupérer les jeux les plus joués et extraire les IDs de jeu.
        final List<dynamic>? rankDataList =
            data['response']['ranks'] as List<dynamic>?;
        if (kDebugMode) {
          print(rankDataList);
        }
        if (rankDataList == null) {
          throw Exception('Aucun jeu trouvé');
        }
        final List<int> gameIds = rankDataList
            .map<int>((dynamic rankData) =>
                (rankData as Map<String, dynamic>)['appid'] as int)
            .toList();

        // Récupérer les détails des jeux les plus joués à l'aide des IDs.
        List<Game> mostPlayedGames = <Game>[];
        for (final int gameId in gameIds) {
          final Map<String, dynamic>? gameDetails =
              await fetchGameDetails(gameId);
          if (gameDetails != null) {
            mostPlayedGames.add(Game.fromJson(gameDetails));
          }
        }
        //if (kDebugMode) {
        //  print(mostPlayedGames.toString());
        //}
        return mostPlayedGames;
      } else {
        if (kDebugMode) {
          print('Status code: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response body: ${response.body}');
        }
        throw Exception(
            'Erreur lors de la récupération des jeux les plus joués.');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
      throw Exception(
          'Erreur lors de la récupération des jeux les plus joués.');
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
