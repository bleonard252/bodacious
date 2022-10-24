{ pkgs ? import <nixpkgs> { } }:
with pkgs;

let
  android-nixpkgs = callPackage (import (builtins.fetchGit {
    url = "https://github.com/tadfisher/android-nixpkgs.git";
  })) {
    # Default; can also choose "beta", "preview", or "canary".
    channel = "stable";
  };
  android-sdk = android-nixpkgs.sdk (sdkPkgs: with sdkPkgs; [
    cmdline-tools-latest
    build-tools-30-0-3
    platform-tools
    platforms-android-31
    tools
    patcher-v4
    emulator
  ]);
in
mkShell {
  buildInputs = [
    git
    flutter
    # Android target packages
    jdk android-sdk
    # Linux builds are not (yet) supported via nix builds
  ];
  shellHook = ''
  export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools
  sdkmanager --sdk_root=$ANDROID_HOME
  '';
}