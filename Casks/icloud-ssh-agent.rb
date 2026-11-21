cask "icloud-ssh-agent" do
  version "0.1.4"
  sha256 "06264efe0f8e0d9ba76170173556e41c4d28fad714d4cfd50ab0cf6d26ce9b82" # updated by release workflow

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

  # No uninstall step: the agent watches its own app. When an upgrade replaces
  # it, the agent exits and launchd starts the new version; when an uninstall
  # removes it, the agent unloads itself. (`uninstall launchctl:` would run on
  # every upgrade too, and asks for sudo to check for a system daemon.)
  # Installs older than 0.1.3 lose the agent on upgrade; run
  # `icloud-ssh-agent reload` afterwards.

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
