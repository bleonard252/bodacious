set dotenv-load
set positional-arguments

# Make sure everything necessary is installed
preflight:
  which flutter # if you don’t have it: https://fvm.app/docs/getting_started/installation
  which appimage-builder # if you don’t have it, run: pip install appimage-builder
  which flatpak-builder # if you don’t have it, run: sudo apt install flatpak-builder (or equivalent)

# Build the app in debug mode
build *TARGETS='appbundle': _generate _prerelversion
  for target in {{TARGETS}}; do flutter build $target --debug --dart-define-from-file=.env.json; done

# Prepare for appimage and flatpak builds
_prerelease-appimage:
  #!/usr/bin/env bash
  set -eux
  rm -rf AppDir | true
  mkdir AppDir
  mkdir -p AppDir/usr/share/icons/hicolor/{128x128,1024x1024,64x64}
  cp -r build/linux/x64/release/bundle/. AppDir/
  #cp assets/brand/ic_circle.png AppDir/usr/share/icons/hicolor/128x128/xyz.u1024256.bodacious.png
  echo "If convert isn’t found, install it with: sudo apt install imagemagick (or equivalent)"
  convert assets/brand/ic_circle.png -resize 128x128 AppDir/usr/share/icons/hicolor/128x128/xyz.u1024256.bodacious.png
  convert assets/brand/ic_circle.png -resize 1024x1024 AppDir/usr/share/icons/hicolor/1024x1024/xyz.u1024256.bodacious.png
  cp assets/brand/ic_foreground_small.png AppDir/usr/share/icons/hicolor/64x64/xyz.u1024256.bodacious.png
release-appimage: _prerelease-appimage
  #!/usr/bin/env bash
  set -eux
  mkdir -p build/linux/x64/release/appimage/
  echo If this is not found, run: sudo pip install appimage-builder
  appimage-builder --skip-test
  rm bodacious-x86_64.AppImage
  echo AppImage released to build/linux/x64/release/appimage/bodacious-x86_64.AppImage
release-flatpak: _prerelease-appimage
  #!/usr/bin/env bash
  set -eux
  rm -rf build/linux/x64/release/flatpak/ build/intermediates/flatpak/ linux/flatpak/ephemeral | true
  mkdir -p build/linux/x64/release/flatpak/ build/intermediates/flatpak/ build/intermediates/flatpak-repo/ linux/flatpak/ephemeral
  cp AppDir/usr/share/icons/hicolor/128x128/xyz.u1024256.bodacious.png linux/flatpak/ephemeral/icon.png
  tar -C build/linux/x64/release/bundle -cvf linux/flatpak/ephemeral/Bodacious-Linux-Portable.tar.gz .
  echo If this is not found, run: sudo apt install flatpak-builder
  flatpak-builder --force-clean --repo build/intermediates/flatpak-repo/ build/intermediates/flatpak/ linux/flatpak/xyz.u1024256.Bodacious.yaml
  flatpak build-bundle build/intermediates/flatpak-repo/ build/linux/x64/release/flatpak/xyz.u1024256.Bodacious.flatpak xyz.u1024256.Bodacious
  rm -r linux/flatpak/ephemeral
  echo Flatpak released to build/linux/x64/release/flatpak/xyz.u1024256.Bodacious.flatpak
# Build the app in release mode
release *TARGETS: test-all prebuild
  for target in {{TARGETS}}; do flutter build $target --release --dart-define-from-file=.env.json; done
  # if you didn’t, you should run `just version release` instead
# Run pre-build checks
prebuild: _generate _check
  @# flutter pub run flutter_launcher_icons:main
# Install the app to a target device. Might be helpful to build it first
install:
  flutter install
# Build, install, and run in debug mode. Powered by `flutter run`
run: prebuild _prerelversion _run
# Run the app in profiling mode.
profile:
  flutter run --profile --dart-define-from-file=.env.json
_run:
  #!/usr/bin/env bash
  flutter run --dart-define-from-file=.env.json

# Release the app with standard flavor
release-standard *TARGETS='apk': test-all prebuild
  for target in {{TARGETS}}; do flutter build $target --release --flavor=standard --dart-define-from-file=.env.json; done
  # if you didn’t, you should run `just version release` instead

_generate:
  flutter pub run build_runner build --delete-conflicting-outputs
_check:
  #!/usr/bin/env bash
  shopt -s expand_aliases
  NEED_API=false
  if which jq>/dev/null; then printf ""; elif stat ./build/jq>/dev/null; then alias jq=./build/jq; else wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O ./build/jq; alias jq=./build/jq; chmod +x ./build/jq; fi
  if jq -e '.SPOTIFY_API_KEY' .env.json >/dev/null; then printf ""; else echo "Spotify client ID not set."; NEED_API=true; fi
  if jq -e '.SPOTIFY_SECRET' .env.json >/dev/null; then printf ""; else echo "Spotify client secret not set."; NEED_API=true; fi
  if jq -e '.LASTFM_API_KEY' .env.json >/dev/null; then printf ""; else echo "Last.fm API key not set."; NEED_API=true; fi
  if jq -e '.LASTFM_SECRET' .env.json >/dev/null; then printf ""; else echo "Last.fm shared secret not set."; NEED_API=true; fi
  #if jq '.GENIUS_API_KEY' .env.json >/dev/null; then printf ""; else echo "Genius API key not set."; NEED_API=true; fi
  if jq -e '.DISCORD_APP_ID' .env.json >/dev/null; then printf ""; else echo "Discord App ID not set."; NEED_API=true; fi
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