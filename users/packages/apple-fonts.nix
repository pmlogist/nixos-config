self: super:
let inherit (super) fetchurl p7zip stdenv;
in
{
  apple-fonts = stdenv.mkDerivation {
    pname = "apple-fonts";
    version = "1.0";

    buildInputs = [ p7zip ];

    src = [
      (fetchurl {
        url =
          "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
        sha256 = "m0eDv1CYCkkm5qgbLioI9+ahf0OXSYh0Gkp61vgMSFk=";
      })
      (fetchurl {
        url =
          "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
        sha256 = "uQAY1yMr9SetN/X6UrY2mvfxmIOmNQ0A3IrJQNvi5jM=";
      })
      (fetchurl {
        url =
          "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
        sha256 = "8niJPk3hGfK1USIs9eoxZ6GlM4aZ7ZObmQj2Zomj+Go=";
      })
      (fetchurl {
        url =
          "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
        sha256 = "MAxQkdR40YUDl7z0OYbuwiueOoB2JuYikIu11CqiAto=";
      })
    ];
    sourceRoot = "./";

    preUnpack = "mkdir fonts";

    unpackCmd = ''
      7z x $curSrc >/dev/null
      dir="$(find . -not \( -path ./fonts -prune \) -type d | sed -n 2p)"
      cd $dir 2>/dev/null
      7z x *.pkg >/dev/null
      7z x Payload~ >/dev/null
      mv Library/Fonts/*.otf ../fonts/
      cd ../
      rm -R $dir
    '';

    installPhase = ''
      mkdir -p $out/share/fonts/opentype/{SF\ Pro,SF\ Mono,SF\ Compact,New\ York}
      cp -a fonts/SF-Pro*.otf $out/share/fonts/opentype/SF\ Pro
      cp -a fonts/SF-Mono*.otf $out/share/fonts/opentype/SF\ Mono
      cp -a fonts/SF-Compact*.otf $out/share/fonts/opentype/SF\ Compact
      cp -a fonts/NewYork*.otf $out/share/fonts/opentype/New\ York
    '';
  };

}
