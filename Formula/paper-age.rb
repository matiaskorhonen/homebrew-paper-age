class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.1/paper-age-universal-apple-darwin.tar.gz"
  sha256 "abf726cc8dc909339529d5de46238730f3ddf3bf0278554863570be6ef9f9699"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.1/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "678ff53454f0324681d60a0d840b68993473909b5cf9c912fefa4205a14b51b8"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.1/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a6f1dc7071ca83f89c1af6325de74286144f7b8a218640f6db11f5d1e1bbc8ae"
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
