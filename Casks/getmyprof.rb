# Homebrew cask for a tap (EhsanulHaqueSiam/homebrew-tap, as Casks/getmyprof.rb):
#   brew install --cask EhsanulHaqueSiam/tap/getmyprof
# release.yml fills in the version and checksums on every release.
cask "getmyprof" do
  arch arm: "arm64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "cb8661479f0d2c6212455a4e0e6e822249239b8a4a84b305435d0d910545a079",
         intel: "ebab1b5f044181081710408b50049dee65e56b77299325d921c543f440baddd5"

  url "https://github.com/EhsanulHaqueSiam/getmyprof/releases/download/v#{version}/getmyprof-#{version}-#{arch}.dmg"
  name "getmyprof"
  desc "Find professors who can fund your degree"
  homepage "https://github.com/EhsanulHaqueSiam/getmyprof"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself (apps/desktop/src/updates.ts).
  auto_updates true
  depends_on macos: :monterey

  app "getmyprof.app"

  # Ad-hoc signed until there is a Developer ID: without this Gatekeeper won't open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/getmyprof.app"]
  end

  # The hunt and the app's profile live in ~/.getmyprof and stay.
  zap trash: [
    "~/Library/Logs/getmyprof",
    "~/Library/Preferences/dev.getmyprof.app.plist",
  ]
end
