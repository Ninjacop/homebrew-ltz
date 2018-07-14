class ltz < Formula
    desc "An all purpose, simple, lightweight CLT that helps create projects on the fly"
    homepage "www.github.com/Ninjacop/homebrew-ltz"
    url "www.github.com/Ninjacop/homebrew-ltz/bin/ltz.tar.gz"
    sha256 "69f46aae517c760227aa1272d9c2f6da742c546e4d57002ef83c1d7864a0fa4e"
    version = "1.0.1"

    depends_on "curl"

    def install
        bin.install "ltz"
    end
end
     