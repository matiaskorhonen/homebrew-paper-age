class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.2/paper-age-universal-apple-darwin.tar.gz"
  sha256 "828fc4c4396037a8e04afbb801f5d035be84d595c2586d422f0006f74115dfcc"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.2/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b8cc6b68c48054eb592d463cb553a975a6d99d1cf9635c2334e7fdeb8bb7cf7e"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.2/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0080c8902952431cedc75f07787d2c322e4d5907bb2c24f2b704792ed4a00724"
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
