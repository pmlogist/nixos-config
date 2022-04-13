self: super:
let inherit (super) fetchurl stdenv;
in
{
  apple-cursors = stdenv.mkDerivation {
    name = "apple-cursors";
    version = "1.2.3";

    src = fetchurl {
      url =
        "https://github.com/ful1e5/apple_cursor/releases/download/v1.2.3/macOSMonterey.tar.gz";
      sha256 = "1npq6894drbgk7p370h1askc93vwzprf4rc7rwpcrigy0bzhmdhn";
    };

    installPhase = ''
      install -dm 0755 $out/share/icons
      tar -xf $src -C $out/share/icons 
    '';
  };

}
