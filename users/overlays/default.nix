self: super: {
  wlroots_0_14_1 = super.wlroots.overrideAttrs (old: {
    version = "0.14.1";

    src = super.fetchFromGitHub {
      owner = "swaywm";
      repo = "wlroots";
      rev = "0.14.1";
      sha256 = "1sshp3lvlkl1i670kxhwsb4xzxl8raz6769kqvgmxzcb63ns9ay1";
    };
  });

  sway_1_6_1 = super.sway-unwrapped.overrideAttrs (old: {
    version = "1.6.1";

    src = super.fetchFromGitHub {
      owner = "swaywm";
      repo = "sway";
      rev = "1.6.1";
      sha256 = "0j4sdbsrlvky1agacc0pcz9bwmaxjmrapjnzscbd2i0cria2fc5j";
    };
  });
}
