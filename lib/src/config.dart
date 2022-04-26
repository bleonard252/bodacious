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

  /// Whether or not to use the Android system library instead of
  /// the Bodacious library.
  bool get lastFmScrobbling => _prefs.getBool("lastfm:scrobble") ?? false;
  set lastFmScrobbling(bool to) => _prefs.setBool("lastfm:scrobble", to);
  /// Whether to use Last.fm to fetch metadata for the library.
  bool get lastFmIntegration => _prefs.getBool("lastfm:integrate") ?? false;
  set lastFmIntegration(bool to) => _prefs.setBool("lastfm:integrate", to);

  String? get lastFmToken => _prefs.getString("token:lastfm");
  set lastFmToken(String? to) => to == null ? _prefs.remove("token:lastfm") : _prefs.setString("token:lastfm", to);
  /// The username of the user on Last.fm.
  /// Should always be set with [lastFmToken].
  String? get lastFmUsername => _prefs.getString("lastfm:username");
  set lastFmUsername(String? to) => to == null ? _prefs.remove("lastfm:username") : _prefs.setString("lastfm:username", to);
}

class ROConfig implements Config {
  @override
  final List<String> libraries;
  @override
  final bool useSystemLibrary;
  @override
  final bool wideCompactNowPlaying;
  @override
  final String? lastFmToken;
  @override
  final String? lastFmUsername;
  @override
  final bool lastFmIntegration;
  @override
  final bool lastFmScrobbling;

  @override
  SharedPreferences get _prefs => throw UnsupportedError("Not necessary");

  ROConfig(Config config) :
    libraries = config.libraries,
    useSystemLibrary = config.useSystemLibrary,
    wideCompactNowPlaying = config.wideCompactNowPlaying,
    lastFmScrobbling = config.lastFmScrobbling,
    lastFmIntegration = config.lastFmIntegration,
    lastFmToken = config.lastFmToken,
    lastFmUsername = config.lastFmUsername;

  @override
  noSuchMethod(Invocation invocation) {
    if (invocation.isSetter) {
      return;
    }
    return super.noSuchMethod(invocation);
  }
}

class APIKeys {
  final String? discordAppId = setNullIfEmpty(const String.fromEnvironment("DISCORD_APP_ID"));
  final String? lastfmApiKey = setNullIfEmpty(const String.fromEnvironment("LASTFM_API_KEY"));
  final String? lastfmSecret = setNullIfEmpty(const String.fromEnvironment("LASTFM_SECRET"));

  static String? setNullIfEmpty(String value) {
    if (value == "") {
      return null;
    } else {
      return value;
    }
  }
}