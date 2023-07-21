import 'package:intership_app/model/song.dart';

class SongsListFromApi {
  List<Song> _result = [];

  SongsListFromApi.fromJson(Map<String, dynamic> parsedJson) {
    List<Song> songList = [];

    List<dynamic> trackList = parsedJson["message"]["body"]["track_list"];
    final numberOfSongs = trackList.length;

    for (int i = 0; i < numberOfSongs; i++) {
      Map<String, dynamic> track = trackList[i]["track"];
      Song song = Song(
        albumName: track["album_name"],
        artistId: track["artist_id"],
        artistName: track["artist_name"],
        explicit: track["explicit"],
        hasLyrics: track["has_lyrics"],
        numFavourite: track["num_favourite"],
        trackId: track["track_id"],
        commonTrackId: track["commontrack_id"],
        trackName: track["track_name"],
        trackRating: track["track_rating"],
      );

      songList.add(song);
    }

    _result = songList;
  }

  List<Song> get result => _result;
}
