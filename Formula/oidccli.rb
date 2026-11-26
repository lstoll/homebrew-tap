class Oidccli < Formula
  desc "Obtain OIDC tokens for local CLI use"
  homepage "https://github.com/lstoll/oidccli"
  version "0.2.0"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-darwin-arm64.tar.gz"
      sha256 "b483a8c294b7022c74a1044060a3231598d47ca837f1b6d2dbf6c9eb6c1c41f0"
    end
    on_intel do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-darwin-amd64.tar.gz"
      sha256 "e120da5862742a2e49fccd31113f5f40c2bee99a38d740b030badce7db15a66c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-linux-arm64.tar.gz"
      sha256 "6ede3daac4e833530938d4224a465ae9c020f4ed7cc3ac44f808c5f61b1257e8"
    end
    on_intel do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-linux-amd64.tar.gz"
      sha256 "f78c10a883afd0bafbcc1c1f5f4da6d680c58abbd8dcbf08e1a58cc7ac6db478"
    end
  end

  def install
    bin.install "oidccli"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/oidccli --help")
  end
end
