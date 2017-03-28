''
Nix is:
- Lazy
- Functional
- Strongly, dynamically typed.
''

# Output:
"Nix is:\n- Lazy\n- Functional\n- Strongly, dynamically typed.\n"

1 + 1

# Output:
2

# Basic types
[
	null
	true false # Boolean
	123 # Integers
	"Strings"
	.git/HEAD # Paths
]

# Output:
[
	null,
	true,
	false,
	123,
	"Strings",
	"/nix/store/88dswhvkja0lcl9azfi4s8a93vmq5yga-HEAD"
]

# Strings
"Hello" + " World"

# Output:
"Hello World"

"Interpolation : ${ "foo" + "bar" }"

# Output:
"Interpolation : foobar"

''
Multi-line strings.
With interpolation: ${ "anything" + " in " + "here" }
''

# Output:
"Multi-line strings.\nWith interpolation: anything in here\n"

# Sets (aka Dictionaries/Maps)
{
	a = 1;
	b = 2;
}

# Output:
{
	"a": 1,
	"b": 2
}

# Set syntax sugar.
{
	a.b.c = 1;
}

# Output:
{
	"a": {
		"b": {
			"c": 1
		}
	}
}

# Works for multiple values as well.
{
	foo.bar.baz = "thing";
	foo.fab = "other";

	my.nix.set = { one = 1; two = 2; };
	my.nix.num = 437;
}

# Output:
{
	"foo": {
		"bar": {
			"baz": "thing"
		},
		"fab": "other"
	},
	"my": {
		"nix": {
			"num": 437,
			"set": {
				"one": 1,
				"two": 2
			}
		}
	}
}

# Sets can reference themselves.
rec {
	attr-three = attr-two + 3;
	attr-two = attr-one + 2;
	attr-one = 1;
}

# Output:
{
	"attr-one": 1,
	"attr-three": 6,
	"attr-two": 3
}

# You can get values out of sets.
rec {
	my-set = { a = 1; b = 2; c = 3; };

	fetch-a = my-set.a;
}.fetch-a

# Output:
1

# Dynamic keys.
rec {
	some-value = "foo";
	"key-from-${some-value}" = 5;
}

# Output:
{
	"key-from-foo": 5,
	"some-value": "foo"
}

# Lists
[ 1 2 (3 + 4) ]

# Output:
[
	1,
	2,
	7
]

# Local variables
let
	a = 1;
	b = 2;
in a + b

# Output:
3

# Object Lookup.
let
	pkgs = { foo = "foo"; bar = "bar"; baz = "baz"; };
	deps = with pkgs; [ foo baz ];
in deps

# Output:
[
	"foo",
	"baz"
]

# Library functions.
let
	lib = import <nixpkgs/lib>;
	list = [ 1 2 3 ];
in lib.reverseList list;

# Output:
error: syntax error, unexpected ';', expecting $end, at (string):5:24

# User functions
let
	my-func = a: a + 1;
	r1 = my-func 4;
	a1 = assert r1 == 5; true;
	
	curried-func = a: b: a + b;
	partially-applied = curried-func 3;
	r2 = partially-applied 4;
	a2 = assert r2 == 7; true;
in [ a1 a2 ]

# Output:
[
	true,
	true
]

