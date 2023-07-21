class SongLyrics {
  SongLyrics({
    required this.lyricsId,
    required this.explicit,
    required this.lyricsBody,
  });

  int lyricsId;
  int explicit;
  List<String> lyricsBody;
}
