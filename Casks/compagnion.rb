cask "compagnion" do
  version "0.1.0,137"
  sha256 "57c06a42092dff9533018ee794b5ba5568794d8a22a93c32e84c30be6e4ae4ae"

  url "https://github.com/innovative365nl/compagnion/releases/download/v#{version.csv.first}-#{version.csv.second}/Compagnion-#{version.csv.first}-#{version.csv.second}.dmg"
  name "Compagnion"
  desc "Run Claude Code and Codex agents in parallel, each in its own git worktree"
  homepage "https://github.com/innovative365nl/compagnion"

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
