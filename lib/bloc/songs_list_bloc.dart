import 'dart:async';
import 'package:intership_app/model/song.dart';
import 'package:intership_app/resources/trending_api_provider.dart';

enum SongsAction { fetchList }

class SongsListBloc {
  final _stateStreamController = StreamController<List<Song>>();
  StreamSink<List<Song>> get _songsSink => _stateStreamController.sink;
  Stream<List<Song>> get songsStream => _stateStreamController.stream;

  // as a event we would be getting a songs action
  // either to fetch the list
  final _eventStreamContoller = StreamController<SongsAction>();
  StreamSink<SongsAction> get eventSink => _eventStreamContoller.sink;
  Stream<SongsAction> get _eventStream => _eventStreamContoller.stream;

  void dispose() {
    _stateStreamController.close();
    _eventStreamContoller.close();
  }

  SongsListBloc() {
    List<Song> listOfSongs = [];
    _eventStream.listen(
      (event) async {
        if (event == SongsAction.fetchList) {
          try {
            TrendingApiProvider api = TrendingApiProvider();
            listOfSongs = await api.fetchMusicList();
            if (listOfSongs.isNotEmpty) {
              _songsSink.add(listOfSongs);
            } else {
              _songsSink.addError("Some Error Occured");
            }
          } on Exception {
            _songsSink.addError("Some error Occured");
          }
        }
      },
    );
  }
}
