class Glosa < Formula
  desc "Local-first review workspace for documents drafted by AI coding agents"
  homepage "https://github.com/davebream/glosa"
  url "https://registry.npmjs.org/@davebream/glosa/-/glosa-0.1.0-alpha.43.tgz"
  sha256 "5057ca2949c8e147e45fc7f615db2c1107f5d3c98e331626f762dbdab8a932b2"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@davebream/glosa"
    strategy :json do |json|
      json["dist-tags"]&.values
    end
  end

  depends_on "bun"
  depends_on :macos

  def install
    ENV["BUN_INSTALL"] = libexec
    ENV["BUN_INSTALL_CACHE_DIR"] = buildpath/"bun-cache"
    system formula_opt_bin("bun")/"bun", "add", "--global", cached_download
    # The CLI starts with `#!/usr/bin/env bun`; pin Homebrew's Bun so a bare PATH still works.
    (bin/"glosa").write_env_script libexec/"bin/glosa", PATH: "#{formula_opt_bin("bun")}:$PATH"
  end

  def caveats
    <<~EOS
      This formula installs the glosa command line only, on Homebrew's Bun. The desktop app is
      the glosa cask, which carries the same command line. Install one or the other: both link
      glosa into #{HOMEBREW_PREFIX}/bin, so the second one fails to link.

      glosa never writes into your agent's configuration. Add the Claude Code plugin the same way
      as before:
        /plugin marketplace add davebream/glosa
        /plugin install glosa

      Update with: brew upgrade glosa
    EOS
  end

  test do
    ENV["GLOSA_HOME"] = testpath/"glosa-home"
    assert_match version.to_s, shell_output("#{bin}/glosa --version")
  end
end
