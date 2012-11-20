
{shared{
  open Eliom_lib

  type service_setting' = {
    status : bool option ;
    dummy_img : string list option;
    txt_info : string option ;
    perma_option : bool option ;
    language : string option ;
  }
  type service_setting = string * service_setting'
  type settings = {
    services : service_setting list option ;
    info_link : string option ;
    txt_help : string option ;
    settings_perma : string option ;
    css_path : string list option ;
  }
  let txt_info =
    "Click twice for your privacy: The button won't be activated until you click it. After clicking you can send your recommendation. Data may already be sent to third-parties when activated. See <em>i</em>."
  let facebook ?status ?(dummy_img=["socialshareprivacy";"images";"dummy_facebook_en.png"])
      ?(txt_info=txt_info) ?perma_option ?(language="en_US") () =
    "facebook", { status ; dummy_img = Some dummy_img ; txt_info = Some txt_info ;
                  perma_option ; language = Some language }
  let twitter ?status ?dummy_img ?(txt_info=txt_info) ?perma_option ?language () =
    "twitter", { status ; dummy_img ; txt_info = Some txt_info ; perma_option ; language }
  let gplus ?status ?dummy_img ?(txt_info=txt_info) ?perma_option ?(language="en") () =
    "gplus", { status ; dummy_img ; txt_info = Some txt_info ; perma_option ; language = Some language }
  let txt_help =
    "If you click one of these buttons, information will be sent to Facebook, Twitter, or Google in the U.S.A. where they will possibly be stored."
  let settings_perma =
    "Activate permanently and accept data transmission."
  let settings ?(services=[facebook (); twitter (); gplus ()]) ?info_link ?(txt_help=txt_help) ?(settings_perma=settings_perma) ?css_path () =
    { services = Some services ; info_link ; txt_help = Some txt_help ; settings_perma = Some settings_perma; css_path }
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

  let services_obj service_settings =
    Js.Unsafe.obj
      (Array.of_list
         (List.map
            (fun (name, service_setting) ->
              name, service_obj service_setting)
            service_settings))

  let settings_obj { services ; info_link ; txt_help ; settings_perma ; css_path } =
    let list = [
      Option.map (fun x -> "services", Js.Unsafe.inject (services_obj x)) services;
      Option.map (fun x -> "info_link", Js.Unsafe.inject (Js.string x)) info_link;
      Option.map (fun x -> "txt_help", Js.Unsafe.inject (Js.string x)) txt_help;
      Option.map (fun x -> "settings_perma", Js.Unsafe.inject (Js.string x)) settings_perma;
      Option.map (fun x -> "css_path", Js.Unsafe.inject (Js.string (String.concat "/" x))) css_path;
    ] in
    Js.Unsafe.obj (Array.of_list (List.map_filter (fun x -> x) list))

  let jquery : ?settings:settings -> JQuery.jQuery Js.t -> JQuery.jQuery Js.t =
    fun ?(settings=settings ()) jq ->
      let obj = settings_obj settings in
      Firebug.console##log_2(Js.string "socialSharePrivacy", obj);
        Js.Unsafe.meth_call jq "socialSharePrivacy" [|obj|]
}}

{shared{

  let css () = []
  let js_files () = [ ["jquery.js"] ; ["socialshareprivacy";"jquery.socialshareprivacy.js"] ]

  let elt ?settings () =
    List.iter Eliom_tools.with_js_file (js_files ());
    let open Eliom_content in
    let elt = Html5.D.div [] in
    ignore {unit{
      ignore
        (jquery ?settings:%settings
           (JQuery.jQelt (Eliom_content.Html5.To_dom.of_element %elt)))
    }};
    elt

}}

{client{
  let _link = ()
}}
