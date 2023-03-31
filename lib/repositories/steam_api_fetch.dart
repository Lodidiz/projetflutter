import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projet/models/game_search.dart';

class SteamApiFetch {
  static const String _baseUrl = 'https://store.steampowered.com/api';

  Future<GameSearch> fetchGameDetails(int gameId) async {
    final http.Response response = await http.get(
      Uri.parse('$_baseUrl/appdetails?appids=$gameId'),
      headers: <String, String>{
        'x-requested-with': 'XMLHttpRequest',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse[gameId.toString()]['success']) {
        return GameSearch.fromJson(jsonResponse[gameId.toString()]['data']);
      } else {
        throw Exception('Failed to fetch game details for gameId: $gameId');
      }
    } else {
      throw Exception('Failed to fetch game details for gameId: $gameId');
    }
  }
}
