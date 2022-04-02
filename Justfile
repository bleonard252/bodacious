set dotenv-load
set positional-arguments

# Build the app in debug mode
build *TARGETS='apk': prebuild
  for target in {{TARGETS}}; do flutter build $target --debug; done
# Build the app in release mode
release *TARGETS='apk': prebuild test-all
  for target in {{TARGETS}}; do flutter build $target --release; done
prebuild: && check
  flutter pub run build_runner build
  @# flutter pub run flutter_launcher_icons:main
check:
  need_api := false
  if "$SPOTIFY_API_KEY" == ""; then echo "Spotify API key not set."; need_api := true; fi
  if "$LASTFM_API_KEY" == ""; then echo "Last.fm API key not set."; need_api := true; fi
  if "$LASTFM_SECRET" == ""; then echo "Last.fm secret not set."; need_api := true; fi
  if "$GENIUS_API_KEY" == ""; then echo "Genius API key not set."; need_api := true; fi
  if need_api == false; then echo "All API keys are set! You are ready to go."; fi

test-infer:
  flutter test test/metadata_readers/infer.dart
test-all: test-infer
  echo 'All tests done'