import 'package:shared_preferences/shared_preferences.dart';

class Config {
  final SharedPreferences _prefs;
  Config(this._prefs);

  /// Whether or not to use the Android system library instead of
  /// the Bodacious library.
  /// This should turn off the indexer and 
  bool get useSystemLibrary => _prefs.getBool("use-system-library") ?? false;
  set useSystemLibrary(bool to) => _prefs.setBool("use-system-library", to);
  /// **NOTE: This is an unmodifiable list!**
  /// To change it:
  /// ```dart
  /// config.libraries = List.from(config.libraries)
  /// ..add("string");
  /// ```
  List<String> get libraries => List.unmodifiable(_prefs.getStringList("libraries") ?? []);
  set libraries(List<String> to) => _prefs.setStringList("libraries", to);
  /// Whether to show Now Playing on the sidebar (`true`) or across the bottom
  /// (default, `false`). This only applies when using the large frame.
  bool get wideCompactNowPlaying => _prefs.getBool("wide-compact-now-playing") ?? false;
  set wideCompactNowPlaying(bool to) => _prefs.setBool("wide-compact-now-playing", to);

  String? get lastFmToken => _prefs.getString("token:lastfm");
  set lastFmToken(String? to) => to == null ? _prefs.remove("token:lastfm") : _prefs.setString("token:lastfm", to);
}

class ROConfig implements Config {
  @override
  final List<String> libraries;
  @override
  final bool useSystemLibrary;
  @override
  final bool wideCompactNowPlaying;
  @override
  // ignore: prefer_void_to_null
  final Null lastFmToken = null;

  @override
  SharedPreferences get _prefs => throw UnsupportedError("Not necessary");

  ROConfig(Config config) :
    libraries = config.libraries,
    useSystemLibrary = config.useSystemLibrary,
    wideCompactNowPlaying = config.wideCompactNowPlaying;

  @override
  noSuchMethod(Invocation invocation) {
    if (invocation.isSetter) {
      return;
    }
    return super.noSuchMethod(invocation);
  }
}