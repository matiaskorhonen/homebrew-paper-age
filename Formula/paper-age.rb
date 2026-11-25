class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.6.1/paper-age-universal-apple-darwin.tar.gz"
  sha256 "6f74a6ffcc464ea0786d94561674a420dc4d1a9510acd8aefef8727b92e72b13"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.6.1/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f66607802bc0d5b6f6c32afc8c8a93d8c553f09235aba0be05bd6e86df45fec1"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.6.1/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5102a8d10a394bab4de34791cef037bd9b012c3ccf424b90491f6016380c1271"
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
