class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.2.1/paper-age-universal-apple-darwin.tar.gz"
  sha256 "f89f9331099c3ed0fe9d0bb82a4899d2225e4e0ff77945456a722bdf711d6cef"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.2.1/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bc3c6b80ed4853ad0213efdb064b6c87ee7c44dc727cab5a13f117e950c4e68e"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.2.1/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cddc558ac76c6ce8a47c1ea43b14201ff5b557816275dcbca3a97e5039128719"
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
