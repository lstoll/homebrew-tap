cask "age-plugin-icloud" do
  version "0.2.0"
  sha256 "d042886ed4a4c4e502d6d487d08e346fe0f034e3f14e4091e7d37b352cb67e77"

  url "https://github.com/lstoll/icloud-keys/releases/download/age-plugin-icloud-v#{version}/age-plugin-icloud-#{version}-darwin.zip"
  name "age-plugin-icloud"
  desc "Age plugin that stores secrets in iCloud Keychain"
  homepage "https://github.com/lstoll/icloud-keys"

  # The repo also releases icloud-ssh-agent, so github_latest would be wrong.
  # Releases are age-plugin-icloud-v* (v0.1.0 predates the prefix).
  livecheck do
    url :url
    regex(/^(?:age-plugin-icloud-)?v(\d+(?:\.\d+)+)$/i)
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

  app "age-plugin-icloud.app"
  # Symlink, not a copy: AMFI kills a Mach-O taken out of the bundle.
  binary "#{appdir}/age-plugin-icloud.app/Contents/MacOS/age-plugin-icloud"

  # No zap: dummy background .app, secrets live in iCloud Keychain.
end
