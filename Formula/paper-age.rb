class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.0.1/paper-age-universal-apple-darwin.tar.gz"
  sha256 "cad2b85e5df6b01388c185993062300deb177a9d2b56be478d2db7baf9b30d4f"
  license "MIT"
  version "1.0.1"

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
