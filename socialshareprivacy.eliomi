
{shared{

  type settings
  type service_setting

  (** {2 Creation of the plugin} *)

  (** Creation of an Eliom element containing the plugin *)
  val elt : ?settings:settings -> unit -> Html5_types.div Eliom_content.Html5.elt
}}

{client{

  (** Appling the socialshareprivacy-plugin to a jQuery *)
  val jquery : ?settings:settings -> JQuery.jQuery Js.t -> JQuery.jQuery Js.t
}}

{shared{

  (** {2 Creating settings} *)

  val facebook : ?status:bool -> ?dummy_img:string list ->
    ?txt_info:string -> ?perma_option:bool -> ?language:string ->
    unit -> service_setting

  val twitter : ?status:bool -> ?dummy_img:string list ->
    ?txt_info:string -> ?perma_option:bool -> ?language:string ->
    unit -> service_setting

  val gplus : ?status:bool -> ?dummy_img:string list ->
    ?txt_info:string -> ?perma_option:bool -> ?language:string ->
    unit -> service_setting

  val settings : ?services:service_setting list -> ?info_link:string ->
    ?txt_help:string -> ?settings_perma:string -> ?css_path:string list ->
    unit -> settings
}}

{shared{

  (** {2 Necessary files} *)

  (** The list of external JavaScript necessary for the socialshareprivacy-plugin. *)
  val js_files : unit -> string list list
}}

{client{
  val _link : unit
}}
