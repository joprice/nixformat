open Nix

let file_names = ref ([]: string list)
let out = ref stdout

let main () =
  Arg.parse [] (fun x -> file_names := x :: !file_names) "";
  let files = match !file_names with
    | [] -> [stdin, "<stdin>"]
    | names -> List.map (fun n -> open_in n, n) names
  in
  files
  |> List.rev
  |> List.iter (fun (file, name) ->
      let lexbuf = Lexer.set_filename name (Lexing.from_channel file) in
      let q, s = Queue.create (), ref [] in
      try
        lexbuf
        |> Parser.main (Lexer.next_token q s)
        |> Simple_printer.print !out;
        output_char !out '\n'
      with
      | Lexer.Error msg ->
        Printf.eprintf "lexing error: %s\n" msg
      | Parser.Error ->
        Printf.eprintf "parse error at: %s\n" (Lexer.print_position lexbuf)
    )

let () = main ()
