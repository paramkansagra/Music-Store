import 'package:flutter/material.dart';
import 'package:intership_app/bloc/song_lyrics_bloc.dart';
import 'package:intership_app/model/song.dart';
import 'package:intership_app/model/song_lyrics.dart';

class SongDetails extends StatefulWidget {
  const SongDetails({super.key, required this.song});

  final Song song;

  @override
  State<SongDetails> createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {
  late SongLyricsBloc songLyricsBloc;

  @override
  void initState() {
    songLyricsBloc = SongLyricsBloc(widget.song.commonTrackId);
    songLyricsBloc.songLyricsEventSink.add(SongLyricsAction.fetchLyrics);
    super.initState();
  }

  @override
  void dispose() {
    songLyricsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song.trackName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                  size: 25,
                ),
                Text(
                  "${widget.song.numFavourite}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: StreamBuilder(
                stream: songLyricsBloc.songLyricsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Wait till we fetch your data"),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Some error occured ");
                  } else if (snapshot.hasData) {
                    return SizedBox(child: SongView(snapshot.data!));
                  } else {
                    return const Text("Some error occured");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget SongView(SongLyrics songLyrics) {
    // we have the song lyrics
    // we would display them in a scrollable list view
    // other details could be shown in a card
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Arist Name:- ${widget.song.artistName}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Album:- ${widget.song.albumName}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          ...songLyrics.lyricsBody.map((e) => Text(e)),
        ],
      ),
    );
  }
}
