template={}

function template.print_header(tex)
   tex.print([[\begin{center}\textsf{{\Large Rechenblatt}\\Zahlenraum bis 1000\\Ohne Hunderterübergang}\end{center}\vspace{1cm}]])
end

function template.print_table_env_begin(tex)
   tex.print([[\begin{tabular}{R@{\hspace{3cm}}R@{\hspace{3cm}}R}]])
end   

function template.print_table_env_end(tex)
  tex.print([[\end{tabular}\pagebreak]])
end   

function template.print_aufgaben(tex)
   for i=1, 15 do
      tex.print("$")
      tex.print(rechnen.create(900,99))
      tex.print("$ & $")
      tex.print(rechnen.create(900,99))
      tex.print("$ & $")
      tex.print(rechnen.create(900,99))
      tex.print("$")
      tex.print("\\\\[2ex]")
   end
end

return template
