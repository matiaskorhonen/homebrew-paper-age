class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.1/paper-age-universal-apple-darwin.tar.gz"
  sha256 "a2ec8b39a012aab4a094a1b01fa01729f9fe936209b2b0ea179fd1a45c2674f7"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.1/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a31c3105ecc9658200fcb9387170662f1e1069c96e8fd3af380283cac2c9a9cd"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.1/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8851340019aea97d08f9c967647f401e1b868aec11d8e0bf4a96eb44f4a8f747"
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
