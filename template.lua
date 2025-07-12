template={}

local operators = {}
operators["add"] = "$+$"
operators["subt"] = "$-$"
operators["mult"] = "\\cdot"
operators["div"] = "$:$"

function template.print_table_env_begin(tex)
   tex.print([[\begin{tabular}{@{}c@{\hspace{1cm}}c@{\hspace{1cm}}c@{}}]])
end

function template.print_table_env_end(tex)
  tex.print([[\end{tabular}\clearpage]])
end   

function template.print_aufgabe_begin(tex)
   tex.print([[\begin{tabular}{@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}c@{\hspace{1pt}}}]])
end   

function template.print_aufgabe_end(tex)
  tex.print([[\end{tabular}]])
end   

function template.print_aufgaben(tex)
   require "rechnen"
   for i=1, 5 do
--      tex.print(template.print_single_aufgabe(tex))
--      tex.print(" & ")
      tex.print(template.print_single_aufgabe(tex))
      tex.print(" & ")
      tex.print(template.print_single_aufgabe(tex))
      tex.print("\\\\[1ex]")
   end
end



function template.print_single_aufgabe(tex)
   require "rechnen"
   aufgabe = rechnen.create_aufgabe()
   template.print_aufgabe_begin(tex)
   local result= {}
   table.insert(result, template.printnumber(aufgabe.faktor1, rechnen.inbox))
   table.insert(result, rechnen.inbox(operator))
   table.insert(result, " & ")
   table.insert(result, template.printnumber(aufgabe.faktor2, rechnen.inbox))
   tex.print("\\\\")
   tex.print(template.hilfsbereich(aufgabe))
   tex.print("[1ex]")
   tex.print(template.loesungszeile())
   tex.print("\\\\[1cm]")
   template.print_aufgabe_end(tex)   
end

function template.printnumber(z, printer)
   local result = {}
   local p = printer or function(x) return x end
   for c in string.gmatch(tostring(z), ".") do
      if c == '-' then c="$-$" end
      table.insert(result, p(c))
      table.insert(result, " & ")
   end
   return table.concat(result)
end

function template.inbox(c)
   local result = {}
   table.insert(result, [[\fbox{\parbox[b][2ex][c]{1em}{\centering]])
   table.insert(result, c)
   table.insert(result, "}}")
   return table.concat(result)
end

function template.small(c)
   local result = {}
   table.insert(result, [[{\footnotesize \parbox[t][0ex][t]{1em}{\raggedleft]])
   table.insert(result, c)
   table.insert(result, "}}")
   return table.concat(result)
end

function template.hilfszeile(z, aufgabe)
   local result = {}
   startpos = aufgabe.offset_hilfskaestchen
   pos = startpos - z
   for i = 1, pos do
      table.insert(result, " & ")
   end
   for i = 1, aufgabe.anzahl_hilfskaestchen do
      table.insert(result, rechnen.inbox(" ~"))
      table.insert(result, " & ")
   end
   return table.concat(result)
end

function template.hilfsbereich(aufgabe)
   local result= {}
   for i = 1, aufgabe.anzahl_hilfszeilen do
      table.insert(result, template.hilfszeile(i, aufgabe))
      table.insert(result, [[\\]])
   end
   return table.concat(result)
end
      
function template.loesungszeile()
   local result = {}
   for i = 1, aufgabe.anzahl_loesungskaestchen do
      table.insert(result, rechnen.inbox(" ~"))
      table.insert(result, " & ")
   end
   table.insert(result, [[\\]])
   for i =1, aufgabe.anzahl_loesungskaestchen - string.len(tostring(rechnen.kontrolle)) do
      table.insert(result, " & ")
   end
   table.insert(result, template.printnumber(aufgabe.kontrolle, rechnen.small))
   return table.concat(result)
end

return template
