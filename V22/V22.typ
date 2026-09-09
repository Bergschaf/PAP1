#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange

= Durchführung

Über die orangene Pumpe werden Öltröpfchen in den Plattenkondensator gebracht.
Wir wählen ein Tröpfchen aus und messen fünf fall und 5 steigzeiten, bis wir 60
Messwerte haben (davon mindestens 10 von einfach geladenen Tröpfchen).


#figure(
    stack(
        dir: ltr,
        image("Aufbau_1.jpg", width: 30%),
        image("Aufbau_2.jpg", width: 30%),
        image("Aufbau_3.jpg", width: 30%),
    ),
    caption: [Bilder des Versuchsaufbaus],
)

= Protokoll

#figure(
    image("Protokoll.pdf", page: 1),
    caption: [Messprotokoll],
)

= Auswertung

== Überprüfung der Werte von Excel
Wie nehmen einen Fehler durch die Reaktionszeit von $Delta t = 0.2 s$ an. Im
folgenden werden wir die Rechnung Beispielhaft für ein Tröpfchen durchführungen,
das 10 Skaleneinteilung gestiegen und gefallen ist in einer Zeit von
$t_f = qty("11.07+-0.2", "s")$ und $t_s = qty("22.19+-0.2", "s")$. Mit einer
Skalenteilung von $1 "Skt" = qty("5.00+-0.13e-5", "m")$ können wir die Steig-
und Sinkgeschwindigkeiten ausrechnen:

$ v_f = (10 "Skt")/t_f = qty("4.52+-0.14e-5", "m/s") $
$ v_s = (10 "Skt")/t_s = qty("2.25+-0.06e-5", "m/s") $

Aus der Geschwindigkeit des fallenden Tröpfchens können wir den Radius
berechnen:

$ r = sqrt((9 eta_0)/(2 rho g) v_f) = qty("6.57+-0.10e-7", "m") $
Hierbei verwenden wir die (nicht korriegierte) Viskosität von
$eta_0 = qty("1.81e-5", "Ns/m^2")$. Die Dichte des Öls $rho_"Öl"$ hängt von der
Temperatur ab. Im Skript sind zwei Werte gegeben:
$ rho_"Öl" (15 "°C") = qty(877, "kg/m^3") $
$ rho_"Öl" (25 "°C") = qty(871, "kg/m^3") $
Am Anfang des Experiments haben wir im Raum am Anfang und am Ende eine
Luftemperatur $T_0 = 23"°C"$ und $T_1 = 25"°C"$ gemessen. Da auf den Kondensator
eine Lampe scheint und durch die Abdeckung kein großer Luftaustausch mit dem
Raum stattfindet, können wir die Temperatur und damit die Dichte des Öls nur
abschätzen:

$ rho_"Öl" = qty("871.0+-2.0", "kg/m^3") $

Damit können wir die Differenz
$rho = rho_"Öl" - rho_"Luft" = qty("871.0+-2.0", "kg/m^3") - qty(1.29, "kg/m^3") = qty("869.7+-2.0", "kg/m^3")$
berechnen.

Für die Gravitationskonstante $g$ verwenden wir $g = qty("9.81", "m/s^2")$.

Mit dem Radius können wir die Cunningham-Korrektur des Stokeschen Gesetzes (TODO
siehe einleitnug) berechnen:
$ eta = eta_0 / (1 + b/(r + p_L)) $
mit dem Luftdruck $p_L = qty("1000.2", "hPa")$ und der Konstante
$b = qty("7.78e-3", "Pa m")$.

Der Plattenabstand des Kondensator beträgt $d = qty("6.00+-0.05e-3", "m")$. Für
die Spannung hatten wir anfangs $500 V$ eingestellt, der Wert schwankte
anschließend leicht, d.h. wir verwenden $U = qty("500.0+-2.0", "V")$. Damit
können wir die Ladung des Tröpfchens berechnen (TODO reference einleitung):

$
    q = (v_f + v_s) sqrt((9 dot v_f eta^3)/(2 rho g)) (6 pi d)/U = qty("1.54+-0.07e-19", "C")
$
Dieser Wert stimmt mit dem von Excel berechnetwen Wert (Tröpfchen 27) überein.





