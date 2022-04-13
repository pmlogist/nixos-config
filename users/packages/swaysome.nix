self: super:
let inherit (super) rustPlatform fetchFromGitLab;
in
{
  swaysome = rustPlatform.buildRustPackage rec {
    pname = "swaysome";
    version = "1.1.2";

    src = fetchFromGitLab {
      owner = "hyask";
      repo = pname;
      rev = version;
      sha256 = "eX2Pzn5It4yf94ZWH/7yAJjwpayVYvpvbrvk7qvbimg=";
    };

    cargoSha256 = "WXjmXwqeWnQVyFs51t81kHHMMn9HQQjBRw1g1cU+6/M=";
  };
}
