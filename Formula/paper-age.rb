class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.0/paper-age-universal-apple-darwin.tar.gz"
  sha256 "b91c9c8a23b3854531b37e4d9b23ea066cc2e15171795a2293c990c7de00659a"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.0/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "74fc30ae95b4271d6d7b12922e0c5938b2de052a16ce3bb993e4dea8c508f335"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.0/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "978fb17e94b18b5addcde867700ec73419954daffd706046e13a5f5d1b2ad154"
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
