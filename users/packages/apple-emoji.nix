self: super:
let inherit (super) fetchurl stdenv;
in
{
  apple-emoji = stdenv.mkDerivation {
    pname = "apple-emoji";
    version = "1.2.3";

    src = fetchurl {
      url =
        "https://github.com/samuelngs/apple-emoji-linux/releases/download/latest/AppleColorEmoji.ttf";
      sha256 = "D1DNQlUdHLQ7CoSBkoGbPKx3Po2nAfugr5QcWrpp4DU=";
    };

    dontUnpack = true;

    installPhase = ''
      install -dm 0755 $out/share/fonts/truetype
      cp $src $out/share/fonts/truetype
    '';
  };
}
