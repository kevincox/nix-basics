with import <nixpkgs> {};

stdenv.mkDerivation {
	name = "config-file";
	
	PATH = lib.makeBinPath [ pkgs.coreutils ];
	
	builder = builtins.toFile "builder.sh" ''
		mkdir $out
		echo foo > $out/bar
		ln -s $out/{bar,foo}
	'';
}
