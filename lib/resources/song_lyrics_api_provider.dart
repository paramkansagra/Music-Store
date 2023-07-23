import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intership_app/api_keys/api_key.dart';
import 'package:intership_app/model/song_lyrics.dart';
import 'package:intership_app/resources/song_lyrics_from_api.dart';

class SongLyricsApiProvider {
  Future<SongLyrics> fetchSongLyrics(int commonTrackId) async {
    final url = Uri.parse(
        "https://api.musixmatch.com/ws/1.1/track.lyrics.get?commontrack_id=$commonTrackId&apikey=$apiKey");
    final responce = await http.get(url);

    var parsedJson = jsonDecode(responce.body);
    if (responce.statusCode == 200) {
      var songLyrics = SongLyricsFromApi.fromJson(parsedJson);
      return songLyrics.songLyrics;
    } else {
      return SongLyrics(lyricsId: 0, explicit: 0, lyricsBody: []);
    }
  }
}
