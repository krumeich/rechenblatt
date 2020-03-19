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

function rechnen.create(j, k)
   local z1 = math.random(j or 100)
   local z2 = math.random(k or 100)
   local operator = "\\cdot"
   local operation = operations["\\cdot"]
   local aufgabe = {}
   table.insert(aufgabe, z1)
   table.insert(aufgabe, "&")
   table.insert(aufgabe, operator)
   table.insert(aufgabe, "&")
   table.insert(aufgabe, z2)
   table.insert(aufgabe, "& = ")
   if ergebnis_positiv(operation(z1, z2))
   then
      return table.concat(aufgabe)
   else
      rechnen.failed = rechnen.failed+1
      print(table.concat(aufgabe))
      return rechnen.create()
   end
end

return rechnen
