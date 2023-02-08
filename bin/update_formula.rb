#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"

require "addressable/template"
require "http"
require "erb"
require "tty-logger"

logger = TTY::Logger.new
LOGGER = logger

USAGE = "./bin/update_formula.rb [VERSION]\n\n VERSION: semantic version, e.g. 1.2.3"
VERSION_RE = /\Av?(\d+\.\d+\.\d+)\z/

if ARGV.length != 1 || ARGV.first !~ VERSION_RE
  puts USAGE
  exit 1
end

version = ARGV.first.gsub("v", "")
logger.info("Starting update", version: version)

tag_name = "v#{version}"
logger.info("Git tag", name: tag_name)

FORMULA_PATH = File.expand_path("../Formula/paper-age.rb", __dir__)
logger.info("Formula", path: FORMULA_PATH)

URL_TEMPLATES = {
  macos_universal: Addressable::Template.new("https://github.com/matiaskorhonen/paper-age/releases/download/{tag_name}/paper-age-universal-apple-darwin{ext}"),
  linux_arm: Addressable::Template.new("https://github.com/matiaskorhonen/paper-age/releases/download/{tag_name}/paper-age-aarch64-unknown-linux-gnu{ext}"),
  linux_x86_64: Addressable::Template.new("https://github.com/matiaskorhonen/paper-age/releases/download/{tag_name}/paper-age-x86_64-unknown-linux-gnu{ext}")
}

def fetch_sha256(platform:, tag_name:)
  url = URL_TEMPLATES.fetch(platform).expand({tag_name: tag_name, ext: ".sha256"})
  response = HTTP.follow.get(url)
  shasums = response.to_s
  sha256, _filename = shasums.split(/\s+/, 2)
  LOGGER.info("Got digest", platform: platform, sha256: "#{sha256[0..10]}...")
  sha256
end

macos_universal_url = URL_TEMPLATES[:macos_universal].expand({tag_name: tag_name, ext: ".tar.gz"})
macos_universal_sha256 = fetch_sha256(platform: :macos_universal, tag_name: tag_name)
linux_arm_url = URL_TEMPLATES[:linux_arm].expand({tag_name: tag_name, ext: ".tar.gz"})
linux_arm_sha256 = fetch_sha256(platform: :linux_arm, tag_name: tag_name)
linux_x86_64_url = URL_TEMPLATES[:linux_x86_64].expand({tag_name: tag_name, ext: ".tar.gz"})
linux_x86_64_sha256 = fetch_sha256(platform: :linux_x86_64, tag_name: tag_name)

template = ERB.new <<~EOF
  class PaperAge < Formula
    desc "Easy and secure paper backups of secrets"
    homepage "https://github.com/matiaskorhonen/paper-age"

    url "<%= macos_universal_url %>"
    sha256 "<%= macos_universal_sha256 %>"

    on_linux do
      on_arm do
        url "<%= linux_arm_url %>"
        sha256 "<%= linux_arm_sha256 %>"
      end

      on_intel do
        url "<%= linux_x86_64_url %>"
        sha256 "<%= linux_x86_64_sha256 %>"
      end
    end

    version "<%= version %>"
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
EOF

formula = template.result(binding)

logger.info("New formula:")
STDOUT.puts formula

File.open(FORMULA_PATH, "wb") do |f|
  f.write formula
end
logger.info("Wrote formula to file", path: FORMULA_PATH)

logger.success("Done")
