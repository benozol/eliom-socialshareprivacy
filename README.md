Example
=======

With Eliom_tools.F.html (manages the required JavaScript files)


    let share =
      let open Socialshareprivacy in
      elt ~settings:(settings ~services:[facebook ~status:false ()] ()) ()
    in
    Lwt.return
      (Eliom_tools.F.html ~title:""
         (Html5.F.body [share]))

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
