cask "omo-ui" do
  version "0.1.3"
  sha256 "54e8cab77ae8fddb9dcb07e52db1f4b0b2c757e4f1a27e49ddb86de5e1e8eae0"

  url "https://github.com/realsigridjin/omo-ui-macosapp/releases/download/v#{version}/omo-ui-#{version}-arm64-mac.zip"
  name "OmO UI"
  desc "Desktop app for omo built from the DeepSeek Harness GUI"
  homepage "https://github.com/realsigridjin/omo-ui-macosapp"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "OmO UI.app"

  # The app is ad-hoc signed, so Gatekeeper refuses a quarantined copy.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{appdir}}/OmO UI.app"]
  end

  zap trash: [
    "~/Library/Application Support/OmO UI",
    "~/Library/Logs/OmO UI",
    "~/Library/Preferences/com.sigridjineth.omoui.plist",
    "~/Library/Saved Application State/com.sigridjineth.omoui.savedState",
  ]

  caveats <<~EOS
    OmO UI drives omo. If omo is not installed, the app offers to install it, or run:
      curl -fsSL https://get.omo.dev/install.sh | bash
  EOS
end
