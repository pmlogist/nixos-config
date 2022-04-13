{ pkgs, ... }: {
  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;
  users.users.pmlogist = {
    isNormalUser = true;
    hashedPassword =
      "$6$3gfk6OVPJqgZ1/vC$XSKXyougCVlmKEhYUpkPAIB524O9gyjJwPrvPCzVr0hlfwEsgkbEYZRyobVnfUyMbjAk.KRxD9ZlxnhtTM9Q30";
    extraGroups = [ "wheel" "audio" "video" "docker" "networkmanager" ];
    openssh.authorizedKeys.keys = [ (builtins.readFile ../keys/home.txt) ];
  };
}
