class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.6.0/paper-age-universal-apple-darwin.tar.gz"
  sha256 "e653bee2c55ad7b19e86011e70aece58fc333b16a5d7662d019d6325c546ca21"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.6.0/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "10e4de178f85a84410e7919332a0efcd42b420b767d9e85cfe3f8b9c69316cf6"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.6.0/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "723f267ee4a23e0bb91236b00d45281956074757bbae5c7da44170f00011c679"
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
    assert_path_exists testpath/"output.pdf"
  end
end
