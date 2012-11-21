
all:
	eliomc -infer socialshareprivacy.eliom
	eliomc -c socialshareprivacy.eliomi
	eliomc -c socialshareprivacy.eliom
	eliomc -a -o _server/socialshareprivacy.cma _server/socialshareprivacy.cmo
	eliomopt -c socialshareprivacy.eliom
	eliomopt -a -o _server/socialshareprivacy.cmxa _server/socialshareprivacy.cmx
	js_of_eliom -c -package oquery socialshareprivacy.eliomi
	js_of_eliom -c -package oquery socialshareprivacy.eliom
	js_of_eliom -a -o _client/socialshareprivacy.cma -package oquery _client/socialshareprivacy.cmo

doc:
	mkdir -p doc/server
	ocamlfind doc -html -d doc/server -thread -package lwt,lwt.syntax,eliom.server,eliom.syntax.server -syntax camlp4o -ppopt -intf -intf socialshareprivacy.eliomi
	mkdir -p doc/client
	ocamlfind doc -html -d doc/client -thread -package lwt,lwt.syntax,eliom.client,eliom.syntax.client -syntax camlp4o -ppopt -intf -intf socialshareprivacy.eliomi

clean:
	rm -rf doc _server _client

install:
	ocamlfind install socialshareprivacy META
	install -m 744 -d `ocamlfind query socialshareprivacy`/server
	install -m 644 \
	  _server/socialshareprivacy.cmi  \
	  _server/socialshareprivacy.cma  \
	  _server/socialshareprivacy.cmxa \
	  `ocamlfind query socialshareprivacy`/server
	install -m 744 -d `ocamlfind query socialshareprivacy`/client
	install -m 644 \
	  _client/socialshareprivacy.cmi  \
	  _client/socialshareprivacy.cma  \
	  `ocamlfind query socialshareprivacy`/client

uninstall:
	rm -rf `ocamlfind query socialshareprivacy`/server
	rm -rf `ocamlfind query socialshareprivacy`/client
	ocamlfind remove socialshareprivacy
