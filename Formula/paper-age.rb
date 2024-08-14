class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.3/paper-age-universal-apple-darwin.tar.gz"
  sha256 "5e1fb3c27381f428c4fe06e954e6982f5569275da610a445091a2baee2ef5daf"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.3/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c43f1dc41c85a9989516334124d8d731a331c9eca502d2aed9abf3d9143f7822"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.3.3/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "621bc7523d1ed51d6ec8f99ef589eb8e08634f20e95a071e53e387a822582632"
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
