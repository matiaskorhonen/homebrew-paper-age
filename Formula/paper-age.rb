class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.0/paper-age-universal-apple-darwin.tar.gz"
  sha256 "e7797c19d9544424cdf996152c943e7a197d58b77ad00e16fe1b4397368c3baa"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.0/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b955ab71e16bbfe061d931732fd70fc49eba47bab6bfaa1d81769324cfa7023d"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.0/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "48d8171d31aa2a2968a8304ca3b9b6041ef0ebb68730691a0e946e5c04dd1f56"
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
