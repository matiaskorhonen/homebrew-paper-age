class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.4.0/paper-age-universal-apple-darwin.tar.gz"
  sha256 "60d16308c60b991cf1e7b116b28e67bfee602222e1c4a47a8ad458a63e67111a"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.4.0/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "74aa8d5bd98606e09986547a239829f379ba34ff3b1f63444bf11959af392da0"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.4.0/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "05d79d77451abd997c2820e2a31bf6b4e4c9f08e74a3dd1de7740867adc42c5b"
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
