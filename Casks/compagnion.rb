cask "compagnion" do
  version "0.1.0,136"
  sha256 "0ebb1accd82f450a44a2874231280b1fe56aa1552604c7bd705cb849771a2ee1"

  url "https://compagnion.innovative.nl/downloads/Compagnion-#{version.csv.first}-#{version.csv.second}.dmg"
  name "Compagnion"
  desc "Run Claude Code and Codex agents in parallel, each in its own git worktree"
  homepage "https://compagnion.innovative.nl/"

  livecheck do
    url "https://compagnion.innovative.nl/downloads/latest.json"
    strategy :json do |json|
      "#{json["version"]},#{json["build"]}"
    end
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Compagnion.app"
  binary "#{appdir}/Compagnion.app/Contents/Helpers/compagnion"

  # The app is signed ad hoc, not notarized: with the quarantine flag Homebrew sets,
  # macOS refuses to open it.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Compagnion.app"],
        writable_paths: ["Compagnion.app"],
        writable_base:  :appdir
  end

  # Not ~/.compagnion: that holds the repos, worktrees and sessions.
  zap trash: [
    "~/Library/Caches/Compagnion",
    "~/Library/Preferences/email.boots.compagnion.plist",
    "~/Library/Saved Application State/email.boots.compagnion.savedState",
  ]
end
