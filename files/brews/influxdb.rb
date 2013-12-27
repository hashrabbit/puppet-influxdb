require "formula"

class Influxdb < Formula
  homepage "http://influxdb.org"
  url "http://get.influxdb.org/influxdb-0.3.2.src.tar.gz"
  sha1 "6b730a75e6694abd5e913b4ad08936f7661569bd"

  version '0.3.2-boxen1'

  depends_on "leveldb"
  depends_on "protobuf" => :build
  depends_on "bison" => :build
  depends_on "flex" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    flex = Formula.factory('flex').bin/"flex"
    bison = Formula.factory('bison').bin/"bison"

    build_target = build.devel? ? "daemon" : "server"

    system "./configure", "--with-flex=#{flex}", "--with-bison=#{bison}"
    system "make dependencies protobuf parser"
    system "go build #{build_target}"

    bin.install build_target => "influxdb"
    share.install "admin"

  end

end
