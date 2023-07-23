import 'dart:async';

import 'package:intership_app/model/song_lyrics.dart';
import 'package:intership_app/resources/song_lyrics_api_provider.dart';

enum SongLyricsAction { fetchLyrics }

class SongLyricsBloc {
  int commonTrackId = 0;

  final _stateStreamController = StreamController<SongLyrics>();
  StreamSink<SongLyrics> get _songLyricsSink => _stateStreamController.sink;
  Stream<SongLyrics> get songLyricsStream => _stateStreamController.stream;

  final _songLyricsEventStreamController = StreamController<SongLyricsAction>();
  StreamSink<SongLyricsAction> get songLyricsEventSink =>
      _songLyricsEventStreamController.sink;
  Stream<SongLyricsAction> get _songLyricsEventStream =>
      _songLyricsEventStreamController.stream;

  void dispose() {
    _songLyricsEventStreamController.close();
    _stateStreamController.close();
  }

  SongLyricsBloc(this.commonTrackId) {
    SongLyrics songLyrics =
        SongLyrics(lyricsId: 0, explicit: 0, lyricsBody: []);
    _songLyricsEventStream.listen(
      (event) async {
        if (event == SongLyricsAction.fetchLyrics) {
          try {
            SongLyricsApiProvider api = SongLyricsApiProvider();
            songLyrics = await api.fetchSongLyrics(commonTrackId);

            if (songLyrics.lyricsId != 0) {
              _songLyricsSink.add(songLyrics);
            } else {
              _songLyricsSink.addError("Some Error occured");
            }
          } on Exception {
            _songLyricsSink.addError("Some error occured");
          }
        }
      },
    );
  }
}
