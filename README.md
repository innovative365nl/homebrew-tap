# Innovative365 Homebrew tap

```sh
brew install --cask innovative365nl/tap/compagnion
```

| Cask | What |
|---|---|
| `compagnion` | [Compagnion](https://compagnion.innovative.nl/): run Claude Code and Codex agents in parallel, each in its own git worktree. Installs `Compagnion.app` and links the `compagnion` CLI. |

`brew upgrade` brings in a new version; the running app notices and offers to restart once no agent is busy.

## A new version

1. Build and deploy the site with the new app (`./build.sh` in compagnion-website).
2. `./bump.sh` takes the version, build and SHA-256 from the site's `downloads/latest.json` and writes them into `Casks/compagnion.rb`.
3. Commit and push.

`brew livecheck --cask innovative365nl/tap/compagnion` shows whether the cask is behind the site.

Compagnion is signed ad hoc, not notarized. The cask therefore removes the quarantine flag after installing, otherwise macOS refuses to open the app.
