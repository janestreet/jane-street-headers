
NAME := jane-street-headers
PREFIX ?= $(shell grep ^prefix= setup.data | cut -d\" -f 2)

.PHONY: default
default:

install: $(NAME).install
	opam-installer -i --prefix $(PREFIX) $(NAME).install

uninstall: $(NAME).install
	opam-installer -u --prefix $(PREFIX) $(NAME).install

reinstall: $(NAME).install
	opam-installer -u --prefix $(PREFIX) $(NAME).install &> /dev/null || true
	opam-installer -i --prefix $(PREFIX) $(NAME).install

bin.lzo: $(NAME).install
	rm -rf _install
	mkdir _install
	opam-installer -i --prefix _install $(NAME).install
	cd _install && lzop -1 -P -o ../bin.lzo `find . -type f`
	rm -rf _install
