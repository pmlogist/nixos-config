HOST=$(shell hostname)

switch:
	@home-manager switch --flake ".#$(HOST)"

build:
	@home-manager build --flake ".#$(HOST)"

clean-generations:
	@nix-collect-garbage -d

install:
	@nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	@nix-channel --update
	@nix-shell '<home-manager>' -A install
