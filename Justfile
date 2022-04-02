set dotenv-load
set positional-arguments

# Build the app in debug mode
build *TARGETS='appbundle':
  for target in {{TARGETS}}; do flutter build $target --debug; done
# Build the app in release mode
release *TARGETS='apk': test-all
  for target in {{TARGETS}}; do flutter build $target --release; done
# Run pre-build checks
prebuild: _generate && _check
  @# flutter pub run flutter_launcher_icons:main
# Install the app to a target device. Might be helpful to build it first
install:
  flutter install
# Build, install, and run. Powered by `flutter run`
run: prebuild
  flutter run

_generate:
  flutter pub run build_runner build
_check:
  set need_api := false
  if [ "$SPOTIFY_API_KEY" -eq "" ]; then echo "Spotify API key not set."; set need_api := true; fi
  if [ "$LASTFM_API_KEY" -eq "" ]; then echo "Last.fm API key not set."; set need_api := true; fi
  if [ "$LASTFM_SECRET" -eq "" ]; then echo "Last.fm secret not set."; set need_api := true; fi
  if [ "$GENIUS_API_KEY" -eq "" ]; then echo "Genius API key not set."; set need_api := true; fi
  if need_api == false; then echo "All API keys are set! You are ready to go."; fi

# Run metadata inference tests
test-infer:
  flutter test test/metadata_readers/infer.dart
# Run all tests
test-all: test-infer
  echo 'All tests done'