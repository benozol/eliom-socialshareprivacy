
{shared{

  (** {2 Service settings} *)

  type facebook_setting
  type twitter_setting
  type gplus_setting

  val facebook : ?status:bool -> ?dummy_img:string list ->
    ?txt_info:string -> ?perma_option:bool -> ?language:string ->
    unit -> facebook_setting

  val twitter : ?status:bool -> ?dummy_img:string list ->
    ?txt_info:string -> ?perma_option:bool -> ?language:string ->
    unit -> twitter_setting

  val gplus : ?status:bool -> ?dummy_img:string list ->
    ?txt_info:string -> ?perma_option:bool -> ?language:string ->
    unit -> gplus_setting

}}

{shared{

  type settings

  (** {2 Creation of socialshareprivacy} *)

  (** Creation of an Eliom element containing the plugin *)
  val elt : ?facebook:facebook_setting ->
            ?twitter:twitter_setting ->
            ?gplus:gplus_setting ->
            ?info_link:string ->
            ?txt_help:string ->
            ?settings_perma:string ->
            ?css_path:string list ->
            ?uri:string ->
            unit -> [> Html5_types.div ] Eliom_content.Html5.elt
}}

{client{

  (** Applying the socialshareprivacy-plugin to an Eliom element *)
  val apply : ?facebook:facebook_setting ->
              ?twitter:twitter_setting ->
              ?gplus:gplus_setting ->
              ?info_link:string ->
              ?txt_help:string ->
              ?settings_perma:string ->
              ?css_path:string list ->
              ?uri:string ->
              _ Eliom_content.Html5.elt -> unit
}}

{shared{

  (** {2 Necessary files} *)

  (** The list of external JavaScript necessary for the socialshareprivacy-plugin. *)
  val js_files : unit -> string list list
}}

{server{
  val set_js_files : ?jquery:string list -> ?socialshareprivacy:string list -> unit -> unit
}}

{client{

  (** {2 Linking} *)

  (** Client-applications which don't use socialshareprivacy.client
      directly (only {!Socialshareprivacy.elt} on the server) must refer to
      this value (or anything) to ensure that OCaml links the library. *)
  val _link : unit
}}
