class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.3/paper-age-universal-apple-darwin.tar.gz"
  sha256 "29c9f0cdac19c9e6d1cc15dd3eaeeb4e0d04879225d2867aeba597268a6ffad3"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.3/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e2350384ea820b152d5a9b20ff5c0b85fbb74021288ec33b13bc06919e230c1e"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.3/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "62852be4d374263d97431714fdb33833184ec4a80e06d1002f1baf74e7597877"
    end
  end

  def install
    bin.install "paper-age"
    man.mkpath
    man1.install "man/paper-age.1"
    bash_completion.install "completion/paper-age.bash"
    zsh_completion.install "completion/_paper-age"
    fish_completion.install "completion/paper-age.fish"
  end

  test do
    (testpath/"sample.txt").write("Hello World")
    with_env(PAPERAGE_PASSPHRASE: "snakeoil") do
      system bin/"paper-age", "--output", testpath/"output.pdf", testpath/"sample.txt"
    end
    assert_predicate testpath/"output.pdf", :exist?
  end
end
