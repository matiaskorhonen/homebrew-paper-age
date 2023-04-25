class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.2/paper-age-universal-apple-darwin.tar.gz"
  sha256 "e44e6b3832ebeeb55d326646cd0adadbbac990e5a5ccacf2913152b0a3ab3c2c"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.2/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "be12ca6c61147ddcf3bdf77e4a2e0f9fa00be8fa61f6bf278cb6439c180930ed"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.2/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "69c83af17d3e03baae1405776aa262d810bfa5ccf20a7a96f4c76456db8bc148"
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
