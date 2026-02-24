class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.5.0/paper-age-universal-apple-darwin.tar.gz"
  sha256 "4c3ff9c921a9bd7d61e37d30a47d20b1bdb165758d50f49909c5b365dbb8cfe7"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.5.0/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4e9d10392aba53944abc17d6747db18cd868282199b498be4514f52fa47b590c"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.5.0/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "89722cb8fb4a13b5b63741c6818aef114ae478e6bf368ad6dc0e9ba50736216c"
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
