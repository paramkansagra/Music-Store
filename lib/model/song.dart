class Song {
  Song({
    required this.trackId,
    required this.commonTrackId,
    required this.trackName,
    required this.trackRating,
    required this.artistId,
    required this.artistName,
    required this.albumName,
    required this.numFavourite,
    required this.explicit,
    required this.hasLyrics,
  });

  int trackId;
  int commonTrackId;
  String trackName;
  int trackRating;
  int explicit;
  int hasLyrics;
  int numFavourite;
  String albumName;
  int artistId;
  String artistName;
}
