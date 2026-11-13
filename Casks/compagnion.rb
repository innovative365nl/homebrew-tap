cask "compagnion" do
  version "0.1.0,218"
  sha256 "922e0a5d18e44d6857f432d0c02738b80daf265f265ceff908fe84daf97389c2"

  url "https://github.com/innovative365nl/compagnion/releases/download/v#{version.csv.first}-#{version.csv.second}/Compagnion-#{version.csv.first}-#{version.csv.second}.dmg"
  name "Compagnion"
  desc "Run Claude Code and Codex agents in parallel, each in its own git worktree"
  homepage "https://compagnion.dev/"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)-(\d+)$/i)
    strategy :github_latest do |json, regex|
      match = json["tag_name"]&.match(regex)
      next if match.blank?

      "#{match[1]},#{match[2]}"
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Compagnion.app"
  binary "#{appdir}/Compagnion.app/Contents/Helpers/compagnion"

  # Not ~/.compagnion: that holds the repos, worktrees and sessions.
  zap trash: [
    "~/Library/Caches/Compagnion",
    "~/Library/Preferences/email.boots.compagnion.plist",
    "~/Library/Saved Application State/email.boots.compagnion.savedState",
  ]
end
