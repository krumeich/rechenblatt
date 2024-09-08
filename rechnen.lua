#!/usr/bin/env lua

math.randomseed( os.clock() * 1000000000 )

rechnen={failed=0}

local operations = {}
operations["+"] = function(a,b) return a+b end;
operations["-"] = function(a,b) return a-b end;
operations["\\cdot"] = function(a,b) return a*b end;

function rndop()
   math.random(); math.random(); math.random()
   local o = math.random(2)
   if o%2==1 then
      return "+"
   else
      return "-"
   end
end

function ergebnis_positiv(z1)
   return z1 > 0
end

function ergebnis_nicht_groesser_als(z1)
   return z1 <= 1000
end

function kein_uebergang(z1, z2, operation, grenze)
   return z1 // grenze == operation(z1,z2) // grenze
end

function rechnen.inbox(c)
   local result = {}
   table.insert(result, [[\fbox{\parbox[b][2ex][c]{1em}{\centering]])
   table.insert(result, c)
   table.insert(result, "}}")
   return table.concat(result)
end

function rechnen.small(c)
   local result = {}
   table.insert(result, [[{\footnotesize \parbox[t][0ex][t]{1em}{\raggedleft]])
   table.insert(result, c)
   table.insert(result, "}}")
   return table.concat(result)
end

function rechnen.printnumber(z, printer)
   local result = {}
   local p = printer or function(x) return x end
   for c in string.gmatch(tostring(z), ".") do
      table.insert(result, p(c))
      table.insert(result, " & ")
   end
   return table.concat(result)
end

function rechnen.create(j, k)
   local z1 = math.random(j or 100) +100
   local z2 = math.random(k or 100) +100
   local operator = "\\cdot"
   local operation = operations["\\cdot"]
   local aufgabe = {}
   table.insert(aufgabe, rechnen.printnumber(z1, rechnen.inbox))
   table.insert(aufgabe, rechnen.inbox(operator))
   table.insert(aufgabe, " & ")
   table.insert(aufgabe, rechnen.printnumber(z2, rechnen.inbox))
   if ergebnis_positiv(operation(z1, z2))
   then
      --      print (table.concat(aufgabe))
      rechnen.kontrolle = operation(z1, z2)
      return table.concat(aufgabe)
   else
      rechnen.failed = rechnen.failed+1
      print(table.concat(aufgabe))
      return rechnen.create()
   end
end

function rechnen.hilfszeile(z)
   local result = {}
   pos = 4 - z
   for i = 1, pos do
      table.insert(result, " & ")
   end
   for i = 1, 4 do
      table.insert(result, rechnen.inbox(" ~"))
      table.insert(result, " & ")
   end
   return table.concat(result)
end

function rechnen.hilfsbereich()
   local result= {}
   for i = 1, 3 do
      table.insert(result, rechnen.hilfszeile(i))
      table.insert(result, [[\\]])
   end
   return table.concat(result)
end
      
function rechnen.loesungszeile()
   local result = {}
   for i = 1, 7 do
      table.insert(result, rechnen.inbox(" ~"))
      table.insert(result, " & ")
   end
   table.insert(result, [[\\]])
   for i =1, 7- string.len(tostring(rechnen.kontrolle)) do
      table.insert(result, " & ")
   end

   table.insert(result, rechnen.printnumber(rechnen.kontrolle, rechnen.small))

   return table.concat(result)
end

return rechnen
