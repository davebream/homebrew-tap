class Tila < Formula
  desc "State-and-coordination engine for multi-machine agentic work"
  homepage "https://github.com/davebream/tila"
  version "0.2.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/davebream/tila/releases/download/v0.2.7/tila-darwin-arm64"
      sha256 "7d5b29470d4636243aa547270e0f7d2c71c8e6f51c0023b6d6d75ae7c3985ed5"
    end
    on_intel do
      url "https://github.com/davebream/tila/releases/download/v0.2.7/tila-darwin-x64"
      sha256 "fb7bbc41c6ef1e232cec8a7710fd7eafede9ea3799021eb15fb7640ebb9d03ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/davebream/tila/releases/download/v0.2.7/tila-linux-arm64"
      sha256 "48d8e5a3b131f2fe5882095e60c87356bfbcb92df4bbb0ce3c06deb234171f81"
    end
    on_intel do
      url "https://github.com/davebream/tila/releases/download/v0.2.7/tila-linux-x64"
      sha256 "e4ca8e54ecd3848681a880a7df897895bfb0d8abcb9e63646a62ae005ed67f9f"
    end
  end

  def install
    bin.install Dir["tila*"].first => "tila"
    chmod 0755, bin/"tila"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tila --version")
  end
end
