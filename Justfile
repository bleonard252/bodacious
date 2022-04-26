set dotenv-load
set positional-arguments

# Build the app in debug mode
build *TARGETS='appbundle': _generate
  for target in {{TARGETS}}; do flutter build $target --debug; done
# Build the app in release mode
release *TARGETS='apk': test-all prebuild
  for target in {{TARGETS}}; do flutter build $target --release; done
# Run pre-build checks
prebuild: _generate && _check
  @# flutter pub run flutter_launcher_icons:main
# Install the app to a target device. Might be helpful to build it first
install:
  flutter install
# Build, install, and run. Powered by `flutter run`
run: prebuild _run
_run:
  #!/usr/bin/env bash
  flutter run --dart-define DISCORD_APP_ID=$DISCORD_APP_ID --dart-define LASTFM_API_KEY=$LASTFM_API_KEY --dart-define LASTFM_SECRET=$LASTFM_SECRET

_generate:
  flutter pub run build_runner build --delete-conflicting-outputs
_check:
  #!/usr/bin/env bash
  NEED_API=false
  if [[ "$SPOTIFY_API_KEY" == "" ]]; then echo "Spotify API key not set."; NEED_API=true; fi
  if [[ "$LASTFM_API_KEY" == "" ]]; then echo "Last.fm API key not set."; NEED_API=true; fi
  if [[ "$LASTFM_SECRET" == "" ]]; then echo "Last.fm secret not set."; NEED_API=true; fi
  if [[ "$GENIUS_API_KEY" == "" ]]; then echo "Genius API key not set."; NEED_API=true; fi
  if [[ "$DISCORD_APP_ID" == "" ]]; then echo "Discord App ID not set."; NEED_API=true; fi
  #
  if [[ "$NEED_API" == "false" ]]; then echo "All API keys are set! You are ready to go."; fi

# Run metadata gathering tests
test-metadata:
  flutter test test/metadata_readers
# Run widget tests
test-widgets:
  flutter test test/widgets
# Run all tests
test-all: test-metadata test-widgets
  echo 'All tests done'