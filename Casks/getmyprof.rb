# Homebrew cask for a tap (EhsanulHaqueSiam/homebrew-tap, as Casks/getmyprof.rb):
#   brew install --cask EhsanulHaqueSiam/tap/getmyprof
# release.yml fills in the version and checksums on every release.
cask "getmyprof" do
  arch arm: "arm64", intel: "x64"

  version "0.6.0"
  sha256 arm:   "00595dcaa94265f0798dfbee07f82093ec275615e3d22440b7b3895c3deda1ab",
         intel: "6c7aaf824202a1a5d906c08983fd05530655e0fa753af82223175c05cb616872"

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
