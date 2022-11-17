import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:bodacious/models/track_data.dart';

class SearchResult {
  final TrackMetadata? _track;
  final AlbumMetadata? _album;
  final ArtistMetadata? _artist;

  final double accuracy;

  SearchResult.track(TrackMetadata track, {this.accuracy = 0.0})
  : _track = track, _album = null, _artist = null;
  SearchResult.album(AlbumMetadata album, {this.accuracy = 0.0})
  : _track = null, _album = album, _artist = null;
  SearchResult.artist(ArtistMetadata artist, {this.accuracy = 0.0})
  : _track = null, _album = null, _artist = artist;
  SearchResult._(this._track, this._album, this._artist, this.accuracy);

  Type _type() {
    if (_track != null) return TrackMetadata;
    if (_album != null) return AlbumMetadata;
    if (_artist != null) return ArtistMetadata;
    throw UnimplementedError("No data was set");
  }

  bool get isTrack => _type() == TrackMetadata;
  bool get isAlbum => _type() == AlbumMetadata;
  bool get isArtist => _type() == ArtistMetadata;

  T get<T>() {
    //if (T != _type()) throw InvalidTypeException(T, _type());
    if (isTrack) {
      if (_track == null) throw InvalidTypeException(T, _type());
      return _track! as T;
    } else if (isAlbum) {
      if (_album == null) throw InvalidTypeException(T, _type());
      return _album! as T;
    } else if (isArtist) {
      if (_artist == null) throw InvalidTypeException(T, _type());
      return _artist! as T;
    } else {
      throw UnimplementedError("No data was set");
    }
  }

  SearchResult withAccuracy(double accuracy) {
    return SearchResult._(_track, _album, _artist, accuracy);
  }
}

class InvalidTypeException implements Exception {
  final Type actual;
  final Type expected;
  InvalidTypeException(this.actual, this.expected);

  @override
  String toString() => "InvalidTypeException: $actual is not of the expected type $expected";
}