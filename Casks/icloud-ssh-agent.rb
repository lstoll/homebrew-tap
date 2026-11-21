cask "icloud-ssh-agent" do
  version "0.1.3"
  sha256 "d8604a5f39c75cced2c9c9189cd82b17d29980a94d3ca4f9c30b79a9b773ddcd" # updated by release workflow

  url "https://github.com/lstoll/icloud-keys/releases/download/icloud-ssh-agent-v#{version}/icloud-ssh-agent-#{version}-darwin.zip"
  name "icloud-ssh-agent"
  desc "SSH agent that keeps keys in iCloud Keychain"
  homepage "https://github.com/lstoll/icloud-keys"

  # Same repo as age-plugin-icloud: only match icloud-ssh-agent-v* tags.
  livecheck do
    url :url
    regex(/^icloud-ssh-agent-v(\d+(?:\.\d+)+)$/i)
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"] || release["prerelease"]

        match = release["tag_name"]&.match(regex)
        match[1] if match
      end
    end
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "icloud-ssh-agent.app"
  # Symlink, not a copy: AMFI kills a Mach-O taken out of the bundle.
  binary "#{appdir}/icloud-ssh-agent.app/Contents/MacOS/icloud-ssh-agent"

  # No uninstall step: the agent (0.1.3+) watches its own app. When an upgrade
  # replaces it, the agent exits and launchd starts the new version; when an
  # uninstall removes it, the agent unloads itself. (`uninstall launchctl:`
  # would run on every upgrade too, and asks for sudo to check for a system
  # daemon.)
  #
  # Transition only: upgrading from <= 0.1.2 runs that version's
  # `uninstall launchctl:`, which unloads the agent, so reload re-registers it.
  # It does nothing if `install` was never run. Remove once no install is
  # older than 0.1.3. Not postflight_steps: its sandbox blocks the mach lookups
  # SMAppService needs. (brew style and brew itself flag this; expected.)
  postflight do
    system_command "#{appdir}/icloud-ssh-agent.app/Contents/MacOS/icloud-ssh-agent",
                   args: ["reload"]
  end

  caveats <<~EOS
    Register and start the agent (one-time):
      icloud-ssh-agent install

    Then add to ~/.ssh/config:
      Host *
        IdentityAgent ~/.ssh/icloud-ssh-agent.sock

    For git commit signing (and other tools that use SSH_AUTH_SOCK):
      export SSH_AUTH_SOCK=~/.ssh/icloud-ssh-agent.sock
  EOS

  # No zap: keys live in iCloud Keychain.
end
