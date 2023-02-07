class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.0.0/paper-age-universal-apple-darwin.tar.gz"
  sha256 "3b64fffb61c3e3bcc4b0126bbcf30e61ab2d5639879021b990edeffe31574ddb"
  license "MIT"
  version "1.0.0"

  def install
    bin.install "paper-age"
  end

  test do
    (testpath/"sample.txt").write("Hello World")
    with_env(PAPERAGE_PASSPHRASE: "snakeoil") do
      system bin/"paper-age", "--output", testpath/"output.pdf", testpath/"sample.txt"
    end
    assert_path_exists testpath/"output.pdf"
  end
end
