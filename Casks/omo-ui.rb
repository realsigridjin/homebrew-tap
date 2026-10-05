cask "omo-ui" do
  version "0.1.0"
  sha256 "33037142dd155d28a9529beda44f63958ed58cc0c7bad903ad9588cb24904c22"

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
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/OmO UI.app"]
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
