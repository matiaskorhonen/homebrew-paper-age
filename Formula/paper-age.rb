class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.4/paper-age-universal-apple-darwin.tar.gz"
  sha256 "6c4d542f395edfc23ce22bf0a4fbe9aecd06f3135f5297150fe0dc93011c57f5"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.4/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4b2186a8f45c5106edd74bed50c5987332a1c9db60be1adde9ab22e0035a078b"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.1.4/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fe453c9c3935d26c8ae0499d54eab68800da780fa15edda4ff9347baee50cdaa"
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
