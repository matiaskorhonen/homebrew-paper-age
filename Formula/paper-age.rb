class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.2.0/paper-age-universal-apple-darwin.tar.gz"
  sha256 "288c6dcea81eaa4eedba21da33a60615265118a9bee851a94dbeb8139806b1da"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.2.0/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e466dc8d933818da3148635fd4cbfaf627ba532f6dc25757c6ad06b4e6ed21c1"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.2.0/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "80a95872665215f7f0883f3eba004bf6451f8b9f09ad005a33217ebb60ab2712"
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
