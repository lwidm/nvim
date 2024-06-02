# shell.nix

{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
	nativeBuildInputs = with pkgs; [
		lua-language-server
		stylua
		nil
		nixpkgs-fmt
	];

	shellHook = ''
	zsh
	'';
}
