# Innovative365 Homebrew tap

```sh
brew install --cask innovative365nl/tap/compagnion
```

| Cask | What |
|---|---|
| `compagnion` | [Compagnion](https://compagnion.dev/): run Claude Code and Codex agents in parallel, each in its own git worktree. Installs `Compagnion.app` and links the `compagnion` CLI. |

Compagnion updates itself (Settings → General → Update automatically); `brew upgrade --greedy` also brings in a new version.

## A new version

1. `scripts/publish.sh` in CodeCompagnion builds, signs and notarizes the app and puts it in a release of [innovative365nl/compagnion](https://github.com/innovative365nl/compagnion/releases).
2. `./bump.sh` takes the version and build from the newest release's tag and the SHA-256 of its disk image, and writes them into `Casks/compagnion.rb`.
3. Commit and push.

`brew livecheck --cask innovative365nl/tap/compagnion` shows whether the cask is behind the releases.
