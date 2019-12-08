#!/usr/bin/env lua

math.randomseed( os.time() )
math.random(); math.random(); math.random()

rechnen={}

local operations = {}
operations["+"] = function(a,b) return a+b end;
operations["-"] = function(a,b) return a-b end;

function rndop()
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

function kein_uebergang(z1, z2, operation, grenze)
   return z1 // grenze == operation(z1,z2) // grenze
end

function rechnen.create(j, k)
   local z1 = math.random(j or 100)
   local z2 = math.random(k or 10)
   local operator = rndop()
   local operation = operations[operator]
   local aufgabe = {}
   if kein_uebergang(z1, z2, operation, 10) and ergebnis_positiv(operation(z1, z2)) then
      table.insert(aufgabe, z1)
      table.insert(aufgabe, operator)
      table.insert(aufgabe, z2)
      table.insert(aufgabe, " = ")
      table.concat(aufgabe)
      return table.concat(aufgabe)
   else
      return rechnen.create()
   end
end

return rechnen
