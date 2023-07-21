import 'package:intership_app/model/song_lyrics.dart';

class SongLyricsFromApi {
  SongLyrics _songLyrics = SongLyrics(lyricsId: 0, explicit: 0, lyricsBody: []);

  SongLyricsFromApi.fromJson(Map<String, dynamic> parsedJson) {
    final int lyricsId = parsedJson["message"]["body"]["lyrics"]["lyrics_id"];
    final int explicit = parsedJson["message"]["body"]["lyrics"]["explicit"];
    final String lyricsString =
        parsedJson["message"]["body"]["lyrics"]["lyrics_body"];
    List<String> lyricsBody = lyricsString.split('\n');
    lyricsBody = lyricsBody.sublist(0, lyricsBody.length - 3);

    SongLyrics tempSong = SongLyrics(
      lyricsId: lyricsId,
      explicit: explicit,
      lyricsBody: lyricsBody,
    );

    _songLyrics = tempSong;
  }

  SongLyrics get songLyrics => _songLyrics;
}
