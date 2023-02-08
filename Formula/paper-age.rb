class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"

  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.0.1/paper-age-universal-apple-darwin.tar.gz"
  sha256 "cad2b85e5df6b01388c185993062300deb177a9d2b56be478d2db7baf9b30d4f"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.0.1/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7e0c23a3f417c1f6f6c2619f50b8a1cebe8a51dd3edfabd9c829e4edde20580b"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.0.1/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ab0d15ca6bc39e1b09108fcc4cca14a57979260a6dd625475451f680f759b5b1"
    end
  end

  version "1.0.1"
  license "MIT"

  def install
    bin.install "paper-age"
  end

  test do
    (testpath/"sample.txt").write("Hello World")
    with_env(PAPERAGE_PASSPHRASE: "snakeoil") do
      system bin/"paper-age", "--output", testpath/"output.pdf", testpath/"sample.txt"
    end
    assert_predicate testpath/"output.pdf", :exist?
  end
end
