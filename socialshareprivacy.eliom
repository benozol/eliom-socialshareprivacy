
{shared{
  open Eliom_lib

  type service_setting = {
    status : bool option ;
    dummy_img : string list option;
    txt_info : string option ;
    perma_option : bool option ;
    language : string option ;
  }
  type facebook_setting = service_setting
  type twitter_setting = service_setting
  type gplus_setting = service_setting
  type settings = {
    facebook : facebook_setting ;
    twitter : twitter_setting ;
    gplus : gplus_setting ;
    info_link : string option ;
    txt_help : string option ;
    settings_perma : string option ;
    css_path : string list option ;
    uri : string option ;
  }
  let txt_info =
    "Click twice to protect your privacy: This button won't be activated until \
     you click it. You can send your recommendation afterwards. Data may \
     already be sent to third-parties when activated. See <em>i</em>."
  let facebook ?status ?(dummy_img=["socialshareprivacy";"images";"dummy_facebook_en.png"])
      ?(txt_info=txt_info) ?perma_option ?(language="en_US") () =
    { status ; dummy_img = Some dummy_img ; txt_info = Some txt_info ;
      perma_option ; language = Some language }
  let twitter ?status ?dummy_img ?(txt_info=txt_info) ?perma_option ?language () =
    { status ; dummy_img ; txt_info = Some txt_info ; perma_option ; language }
  let gplus ?status ?dummy_img ?(txt_info=txt_info) ?perma_option ?(language="en") () =
    { status ; dummy_img ; txt_info = Some txt_info ; perma_option ; language = Some language }
  let txt_help =
    "If you click one of these buttons, information will be sent to Facebook, Twitter, or Google in the U.S.A. where they will possibly be stored."
  let settings_perma =
    "Activate permanently and accept data transmission."
  let settings ?(facebook=facebook ()) ?(twitter=twitter ()) ?(gplus=gplus ())
      ?info_link ?(txt_help=txt_help) ?(settings_perma=settings_perma) ?css_path ?uri () =
    { facebook ; twitter ; gplus ; info_link ; txt_help = Some txt_help ;
      settings_perma = Some settings_perma ; css_path ; uri }
}}

{client{
  let service_obj { status; dummy_img; txt_info; perma_option; language } =
    let list = [
      Option.map (fun x -> "status", Js.Unsafe.inject (Js.bool x)) status;
      Option.map (fun x -> "dummy_img", Js.Unsafe.inject (Js.string (String.concat "/" x))) dummy_img;
      Option.map (fun x -> "txt_info", Js.Unsafe.inject (Js.string x)) txt_info;
      Option.map (fun x -> "perma_option", Js.Unsafe.inject (Js.bool x)) perma_option;
      Option.map (fun x -> "language", Js.Unsafe.inject (Js.string x)) language;
    ] in
    Js.Unsafe.obj (Array.of_list (List.map_filter (fun x -> x) list))

  let services_obj { facebook ; twitter ; gplus } =
    Js.Unsafe.obj
      [|
        "facebook", service_obj facebook;
        "twitter", service_obj twitter;
        "gplus", service_obj gplus;
      |]

  let settings_obj ({ info_link ; txt_help ; settings_perma ; css_path ; uri } as settings) =
    let list = [
      Some ("services", Js.Unsafe.inject (services_obj settings));
      Option.map (fun x -> "info_link", Js.Unsafe.inject (Js.string x)) info_link;
      Option.map (fun x -> "txt_help", Js.Unsafe.inject (Js.string x)) txt_help;
      Option.map (fun x -> "settings_perma", Js.Unsafe.inject (Js.string x)) settings_perma;
      Option.map (fun x -> "css_path", Js.Unsafe.inject (Js.string (String.concat "/" x))) css_path;
      Option.map (fun x -> "uri", Js.Unsafe.inject (Js.string x)) uri;
    ] in
    Js.Unsafe.obj (Array.of_list (List.map_filter (fun x -> x) list))

  let jquery' ~settings elt =
    let jq = JQuery.jQelt (Eliom_content.Html5.To_dom.of_element elt) in
    let obj = settings_obj settings in
    Firebug.console##log_2(Js.string "socialSharePrivacy", obj);
    ignore (Js.Unsafe.meth_call jq "socialSharePrivacy" [|obj|])

  let apply ?facebook ?twitter ?gplus ?info_link ?txt_help ?settings_perma ?css_path ?uri elt =
    let settings = settings ?facebook ?twitter ?gplus ?info_link ?txt_help ?settings_perma ?css_path ?uri () in
    jquery' ~settings elt
}}

{server{
  let js_files_ref = ref [ ["jquery.js"] ; ["socialshareprivacy";"jquery.socialshareprivacy.js"] ]
  let set_js_files ?jquery ?socialshareprivacy () =
    js_files_ref := Option.to_list jquery @ Option.to_list socialshareprivacy
  let js_files () = !js_files_ref
}}

{client{
  let js_files () = %(js_files ())
}}

{shared{

  let elt ?facebook ?twitter ?gplus ?info_link ?txt_help ?settings_perma ?css_path ?uri () =
    List.iter Eliom_tools.with_js_file (js_files ());
    let open Eliom_content in
    let elt = Html5.D.div [] in
    let settings = settings ?facebook ?twitter ?gplus ?info_link ?txt_help ?settings_perma ?css_path ?uri () in
    ignore {unit{
      jquery' ?settings:%settings %elt
    }};
    elt

}}

{client{
  let _link = ()
}}
