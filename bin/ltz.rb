class Ltz < Formula
    desc "An all purpose, simple, lightweight CLT that helps create projects on the fly"
    homepage "www.github.com/Ninjacop/homebrew-ltz"
    url "https://github.com/Ninjacop/homebrew-ltz/files/2194878/ltz-1.0.1.zip"
    sha256 "63a897eb8e371392f3b2c5f10ff0972a25884f3088d29b04964a09c019397575"
    version = "1.0.1"

    depends_on "curl"

    def install
        bin.install "ltz"
    end

    test do 
    end
end
     