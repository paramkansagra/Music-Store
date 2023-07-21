import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intership_app/api_keys/api_key.dart';
import 'package:intership_app/model/song.dart';
import 'package:intership_app/resources/song_list_from_api.dart';

class TrendingApiProvider {
  Future<List<Song>> fetchMusicList() async {
    try {
      final url = Uri.parse(
          "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=$apiKey&f_has_lyrics=1");
      final response = await http.get(url);

      var parsedJson = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var songsListFromApi = SongsListFromApi.fromJson(parsedJson);
        return songsListFromApi.result;
      } else {
        // If that call was not successful, throw an error.
        return [];
      }
    } on Exception {
      return [];
    }
  }
}
