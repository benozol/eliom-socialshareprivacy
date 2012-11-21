This project provides [Eliom](http://ocsigen.org/eliom) bindings to the
[socialshareprivacy-plugin](http://www.heise.de/extras/socialshareprivacy/).

See the API documentation for
[server](http://benozol.github.com/socialshareprivacy-eliom/doc/server/index.html) and
[client](http://benozol.github.com/socialshareprivacy-eliom/doc/client/index.html).

Example
=======

    My_app.register ~service
      (fun _ _ ->
         Lwt.return
           (Eliom_tools.F.html ~title:""
             (Html5.F.body [
                Socialshareprivacy.elt ~uri:"http://ocsigen.org" ();
              ])))

If your are not using `Eliom_tools.F.html`, you must add the
JavaScript-links to `Socialshareprivacy.get_js_files ()` manually.

Requirements
============

[ocaml-jquery](https://github.com/balat/ocaml-jquery)

Install
=======

 - Install the bindings

         $ make
         $ sudo make install

Install the socialshareprivacy-plugin
=====================================

 - Download and extract the socialshareprivacy plugin

         $ wget http://www.heise.de/extras/socialshareprivacy/jquery.socialshareprivacy.tar.gz
         $ tar xf jquery.socialshareprivacy.tar.gz

 - Apply replace_entities.diff

         $ patch socialshareprivacy/jquery.socialshareprivacy.js < replace_entities.diff

 - Move, copy or link
     - `socialshareprivacy/jquery.socialshareprivacy.js`
     - `socialshareprivacy/socialshareprivacy`
   to your static directory
