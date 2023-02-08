class PaperAge < Formula
  desc "Easy and secure paper backups of secrets"
  homepage "https://github.com/matiaskorhonen/paper-age"
  url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.0.0/paper-age-universal-apple-darwin.tar.gz"
  sha256 "3b64fffb61c3e3bcc4b0126bbcf30e61ab2d5639879021b990edeffe31574ddb"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.0.0/paper-age-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "98a4e9306f932e61fc4076fcbc5fe49933b00817cc35535b530cdd3f287654be"
    end

    on_intel do
      url "https://github.com/matiaskorhonen/paper-age/releases/download/v1.0.0/paper-age-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a263501aac08afbdad2b53e876856ee44830ba79d81f474aef92a80b331a2c6f"
    end
  end

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
