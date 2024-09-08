template={}

function template.print_header(tex)
--   tex.print([[\begin{center}\textsf{Multiplikation bis 1.000.000}\end{center}\vspace{1cm}]])
end

function template.print_table_env_begin(tex)
   tex.print([[\begin{tabular}{@{}c@{\hspace{1cm}}c@{\hspace{1cm}}c@{}}]])
end

function template.print_table_env_end(tex)
  tex.print([[\end{tabular}\clearpage]])
end   

function template.print_aufgabe_begin(tex)
   tex.print([[\begin{tabular}{@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}}]])
end   

function template.print_aufgabe_end(tex)
  tex.print([[\end{tabular}]])
end   

function template.print_aufgaben(tex)
   require "rechnen"
   for i=1, 5 do
      tex.print(template.print_single_aufgabe(tex))
      tex.print(" & ")
      tex.print(template.print_single_aufgabe(tex))
      tex.print(" & ")
      tex.print(template.print_single_aufgabe(tex))
      tex.print("\\\\[1ex]")
   end
end

function template.print_single_aufgabe(tex)
   require "rechnen"
   template.print_aufgabe_begin(tex)
   tex.print(rechnen.create(899,899))
   tex.print("\\\\")
   tex.print(rechnen.hilfsbereich())
   tex.print("[1ex]")
   tex.print(rechnen.loesungszeile())
   tex.print("\\\\[1cm]")
   template.print_aufgabe_end(tex)   
end

return template
