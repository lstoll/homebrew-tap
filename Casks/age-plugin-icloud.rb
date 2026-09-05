cask "age-plugin-icloud" do
  version "0.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/lstoll/age-plugin-icloud/releases/download/v#{version}/age-plugin-icloud-#{version}-darwin.zip"
  name "age-plugin-icloud"
  desc "Age plugin that stores secrets in iCloud Keychain"
  homepage "https://github.com/lstoll/age-plugin-icloud"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "age-plugin-icloud.app"
  # Symlink, not a copy: AMFI kills a Mach-O taken out of the bundle.
  binary "#{appdir}/age-plugin-icloud.app/Contents/MacOS/age-plugin-icloud"

  # No zap: dummy background .app, secrets live in iCloud Keychain.
end
