template={}

function template.print_header(tex)
   tex.print([[\begin{center}\textsf{{\Large Rechenblatt}\\Zahlenraum bis 1.000.000}\end{center}\vspace{0.5cm}]])
end

function template.print_table_env_begin(tex)
   tex.print([[\begin{tabular}{r@{\hspace{0.5em}}c@{\hspace{0.5em}}r@{\hspace{0.5em}}l@{\hspace{4cm}}r@{\hspace{0.5em}}c@{\hspace{0.5em}}r@{\hspace{0.5em}}l@{\hspace{4cm}}r@{\hspace{0.5em}}c@{\hspace{0.5em}}r@{\hspace{0.5em}}l}]])
end   

function template.print_table_env_end(tex)
  tex.print([[\end{tabular}\pagebreak]])
end   

function template.print_aufgaben(tex)
   require "rechnen"
   for i=1, 8 do
      tex.print(rechnen.create(999,999))
      tex.print(" & ")
      tex.print(rechnen.create(999,999))
      tex.print(" & ")
      tex.print(rechnen.create(999,999))
      tex.print("\\\\[2.4cm]")
   end
end

return template
