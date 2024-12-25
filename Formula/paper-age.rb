class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.4/paper-age-universal-apple-darwin.tar.gz"
  sha256 "5019115df6559aace0c1260ac867876254e530560b150b542e207700c55bafba"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.4/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "abeb623640dacaa6be2230889a148509fe17c43cf206a4a456945192afe17a16"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.4/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ae6d14c615a32a3f3d12b3f2b066855fc8847f7c7650a1611de2f744ef6925a0"
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
