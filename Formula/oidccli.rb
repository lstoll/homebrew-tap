class Oidccli < Formula
  desc "Obtain OIDC tokens for local CLI use"
  homepage "https://github.com/lstoll/oidccli"
  version "0.0.0"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-darwin-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-linux-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-linux-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "oidccli"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/oidccli --help")
  end
end
