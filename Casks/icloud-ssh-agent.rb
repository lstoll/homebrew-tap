cask "icloud-ssh-agent" do
  version "0.1.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000" # updated by release workflow

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

  # Stop the agent; macOS drops the SMAppService login item with the app.
  uninstall launchctl: "li.lds.icloud-ssh-agent"

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
