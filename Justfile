set dotenv-load
set positional-arguments

# Make sure everything necessary is installed
preflight:
  which flutter # if you don't have it: https://fvm.app/docs/getting_started/installation
  which appimage-builder # if you don't have it, run: pip install appimage-builder

# Build the app in debug mode
build *TARGETS='appbundle': _generate _prerelversion
  for target in {{TARGETS}}; do flutter build $target --debug --dart-define DISCORD_APP_ID=$DISCORD_APP_ID --dart-define LASTFM_API_KEY=$LASTFM_API_KEY --dart-define LASTFM_SECRET=$LASTFM_SECRET --dart-define SPOTIFY_API_KEY=$SPOTIFY_API_KEY --dart-define SPOTIFY_SECRET=$SPOTIFY_SECRET; done
release-appimage:
  #!/usr/bin/env bash
  set -eux
  rm -rf AppDir | true
  mkdir AppDir
  mkdir -p AppDir/usr/share/icons/hicolor/{128x128,1024x1024,64x64}
  cp -r build/linux/x64/release/bundle/. AppDir/
  #cp assets/brand/ic_circle.png AppDir/usr/share/icons/hicolor/128x128/xyz.u1024256.bodacious.png
  convert assets/brand/ic_circle.png -resize 128x128 AppDir/usr/share/icons/hicolor/128x128/xyz.u1024256.bodacious.png
  convert assets/brand/ic_circle.png -resize 1024x1024 AppDir/usr/share/icons/hicolor/1024x1024/xyz.u1024256.bodacious.png
  cp assets/brand/ic_foreground_small.png AppDir/usr/share/icons/hicolor/64x64/xyz.u1024256.bodacious.png
  mkdir -p build/linux/x64/release/appimage/
  echo If this is not found, run: sudo pip install appimage-builder
  ./build/appimage-builder-x86_64.AppImage --skip-test
  @rm bodacious-x86_64.AppImage
  echo AppImage released to build/linux/x64/release/appimage/bodacious-x86_64.AppImage
# Build the app in release mode
release *TARGETS='apk': test-all prebuild
  for target in {{TARGETS}}; do flutter build $target --release --dart-define DISCORD_APP_ID=$DISCORD_APP_ID --dart-define LASTFM_API_KEY=$LASTFM_API_KEY --dart-define LASTFM_SECRET=$LASTFM_SECRET --dart-define SPOTIFY_API_KEY=$SPOTIFY_API_KEY --dart-define SPOTIFY_SECRET=$SPOTIFY_SECRET; done
  # if you didn't, you should run `just version release` instead
# Run pre-build checks
prebuild: _generate _check
  @# flutter pub run flutter_launcher_icons:main
# Install the app to a target device. Might be helpful to build it first
install:
  flutter install
# Build, install, and run. Powered by `flutter run`
run: prebuild _prerelversion _run
# Run the app in profiling mode.
profile:
  flutter run --profile --dart-define DISCORD_APP_ID=$DISCORD_APP_ID --dart-define LASTFM_API_KEY=$LASTFM_API_KEY --dart-define LASTFM_SECRET=$LASTFM_SECRET --dart-define SPOTIFY_API_KEY=$SPOTIFY_API_KEY --dart-define SPOTIFY_SECRET=$SPOTIFY_SECRET
_run:
  #!/usr/bin/env bash
  flutter run --dart-define DISCORD_APP_ID=$DISCORD_APP_ID --dart-define LASTFM_API_KEY=$LASTFM_API_KEY --dart-define LASTFM_SECRET=$LASTFM_SECRET --dart-define SPOTIFY_API_KEY=$SPOTIFY_API_KEY --dart-define SPOTIFY_SECRET=$SPOTIFY_SECRET

_generate:
  flutter pub run build_runner build --delete-conflicting-outputs
_check:
  #!/usr/bin/env bash
  NEED_API=false
  if [[ "$SPOTIFY_API_KEY" == "" ]]; then echo "Spotify client ID not set."; NEED_API=true; fi
  if [[ "$SPOTIFY_SECRET" == "" ]]; then echo "Spotify client secret not set."; NEED_API=true; fi
  if [[ "$LASTFM_API_KEY" == "" ]]; then echo "Last.fm API key not set."; NEED_API=true; fi
  if [[ "$LASTFM_SECRET" == "" ]]; then echo "Last.fm shared secret not set."; NEED_API=true; fi
  #if [[ "$GENIUS_API_KEY" == "" ]]; then echo "Genius API key not set."; NEED_API=true; fi
  if [[ "$DISCORD_APP_ID" == "" ]]; then echo "Discord App ID not set."; NEED_API=true; fi
  #
  if [[ "$NEED_API" == "false" ]]; then echo "All API keys are set! You are ready to go."; else exit 1; fi

version:
  awk '/^version:[ ]*/ {print $2}' pubspec.yaml | sed 's![+].*!!' > assets/version.txt
_prerelversion:
  # This adds -dev+git.COMMIT (where COMMIT is a truncated hash) to the version number.
  echo '-dev+git.' >> assets/version.txt
  git log HEAD^1..HEAD --pretty --oneline | awk '{print $1}' >> assets/version.txt

# Run metadata gathering tests
test-metadata:
  flutter test test/metadata_readers
# Run widget tests
test-widgets:
  flutter test test/widgets
# Run all tests
test-all: test-metadata test-widgets
  echo 'All tests done'