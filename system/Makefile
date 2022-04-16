HOST=$(shell hostname)

switch:
	@sudo nixos-rebuild switch --flake ".#$(HOST)"

check:
	@nix flake check

lint:
	@nixpkgs-fmt .
