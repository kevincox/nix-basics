with import <nixpkgs> {};

stdenv.mkDerivation rec {
	name = "entr-${version}";
	version = "3.7";
	
	configurePhase = ''
		export PREFIX=$out
		export MAN_PREFIX=$out/man
		./configure
	'';
	
	src = fetchzip {
		url = "http://entrproject.org/code/entr-${version}.tar.gz";
		sha256 = "000vpz3b553d4v169kpqkpiwxgizisadcn7fx6j2kkpzd22dy09a";
	};
}
