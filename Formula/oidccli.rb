class Oidccli < Formula
  desc "Obtain OIDC tokens for local CLI use"
  homepage "https://github.com/lstoll/oidccli"
  version "0.1.1"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-darwin-arm64.tar.gz"
      sha256 "1b0dc78063f2a16e282edbdfa20fe7334b5f5fe5d270c793447c88d63c59a76f"
    end
    on_intel do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-darwin-amd64.tar.gz"
      sha256 "d902a24fddcc4df015379f530ceaabe1708ae0dfb8c1ad903b9de4d3e12f4142"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-linux-arm64.tar.gz"
      sha256 "3e6323401dfd8220fb6a9057fb9791046fde3585a8d13e730effecb399e1b425"
    end
    on_intel do
      url "https://github.com/lstoll/oidccli/releases/download/v#{version}/oidccli-#{version}-linux-amd64.tar.gz"
      sha256 "114dbaafa679f4c94fd9032fed5b8b82308318bec8ed94e181e16e45dafb612d"
    end
  end

  def install
    bin.install "oidccli"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/oidccli --help")
  end
end
