class Oidccli < Formula
  desc "Obtain OIDC tokens for local CLI use"
  homepage "https://github.com/lstoll/oidccli"
  version "0.1.0"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-darwin-arm64.tar.gz"
      sha256 "6368d4ca85441984efed0265b6cadf635f6bd1cb012f232221833a2ebc35aa7a"
    end
    on_intel do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-darwin-amd64.tar.gz"
      sha256 "91760f7ef27b5b6f04eb6d4e86cfa19686c0390126d84e28a2d026bf3ffbd217"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-linux-arm64.tar.gz"
      sha256 "8129e2083eb585a16a304351c81cb9878b547f20133f23b147d2360935800e85"
    end
    on_intel do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-linux-amd64.tar.gz"
      sha256 "c8230860629d82550f11dd37c9164ad47afdad5efc39dba9f8b64081083cdebf"
    end
  end

  def install
    bin.install "oidccli"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/oidccli --help")
  end
end
