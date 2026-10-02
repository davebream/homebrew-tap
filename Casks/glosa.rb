cask "glosa" do
  arch arm: "arm64", intel: "x64"

  version "0.1.0-alpha.41"
  sha256 arm:   "7ae4e19a53258363c85e3aeb39f483e6ae202cbe8a349a100e18589b97603431",
         intel: "e9677581985cdaa923828937d4ed84daf6327f7b429c7e2c6485b9a41d47ba58"

  url "https://github.com/davebream/glosa/releases/download/v#{version}/glosa-#{version}-#{arch}.dmg"
  name "glosa"
  desc "Local-first review workspace for documents drafted by AI coding agents"
  homepage "https://github.com/davebream/glosa"

  livecheck do
    url :url
    strategy :github_releases
    regex(/^v?(\d+(?:\.\d+)+(?:-[\w.]+)?)$/i)
  end

  auto_updates false
  depends_on macos: :ventura

  app "glosa.app"
  binary "#{appdir}/glosa.app/Contents/Resources/bin/glosa"

  uninstall quit: "dev.glosa.app"

  zap trash: [
    "~/Library/Application Support/glosa",
    "~/Library/Caches/dev.glosa.app",
    "~/Library/Caches/dev.glosa.app.ShipIt",
    "~/Library/Logs/glosa",
    "~/Library/Preferences/dev.glosa.app.plist",
    "~/Library/Saved Application State/dev.glosa.app.savedState",
  ]

  caveats <<~EOS
    glosa.app is signed ad hoc, not notarized by Apple, so macOS blocks it, and the glosa
    command line inside it, until you allow it. After installing, and again after each upgrade, run:
      xattr -dr com.apple.quarantine #{appdir}/glosa.app
    If that answers "Operation not permitted", macOS needs your terminal allowed to change apps:
    System Settings, Privacy & Security, App Management. Or open the app once, then choose
    Open Anyway in System Settings, Privacy & Security.

    The glosa command line is linked into #{HOMEBREW_PREFIX}/bin and runs on the Bun runtime
    inside the app, so no separate Bun install is needed. If another glosa install is already
    recorded for the Claude Code plugin, it keeps that role; `glosa doctor` lists every install
    it can see and says which one is recorded.

    glosa never writes into your agent's configuration. Add the Claude Code plugin the same way
    as before:
      /plugin marketplace add davebream/glosa
      /plugin install glosa

    The glosa formula installs the same command line without the app. Install one or the other:
    both link glosa into #{HOMEBREW_PREFIX}/bin, so the second one fails to link.

    A daemon started by glosa keeps running after the app quits; `glosa status` shows it.
    Update with: brew upgrade --cask glosa
  EOS
end
