#!/usr/bin/env lua

math.randomseed( os.clock() * 1000000000 )

rechnen={}

local operations = {}
operations["add"] = function(a,b) return a+b end;
operations["subt"] = function(a,b) return a-b end;
operations["mult"] = function(a,b) return a*b end;
operations["div"] = function(a,b) return a//b end;

function rechnen.negative_zahl()
   math.random(); math.random(); math.random()
   local o = math.random(2)
   return o%2==1
end

function rechnen.create_aufgabe()
   local aufgabe = {}
   local faktor1 = math.random(899)+100
   local faktor2 = math.random(899)+100
   if rechnen.negative_zahl() then faktor1 = faktor1 * -1 end
   if rechnen.negative_zahl() then faktor2 = faktor2 * -1 end
   aufgabe.faktor1 = faktor1
   aufgabe.faktor2 = faktor2
   aufgabe.operation = operations["mult"]
   aufgabe.anzahl_hilfszeilen = 3
   aufgabe.anzahl_hilfskaestchen = 4
   offset_hilfskaestchen = 0
   if faktor1 < 0 then offset_hilfskaestchen = offset_hilfskaestchen+1 end
   if faktor2 < 0 then offset_hilfskaestchen = offset_hilfskaestchen+1 end
   aufgabe.offset_hilfskaestchen = offset_hilfskaestchen + aufgabe.anzahl_hilfskaestchen
   aufgabe.kontrolle = aufgabe.operation(faktor1, faktor2)
   aufgabe.anzahl_loesungskaestchen = tostring(aufgabe.kontrolle)
   return aufgabe
end

return rechnen
