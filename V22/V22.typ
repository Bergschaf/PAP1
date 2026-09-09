#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange

= Einleitung
TODO
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
    scale(85%, stack(
        spacing: -8em,
        image("Protokoll.pdf", page: 1),
        image("Protokoll.pdf", page: 2),
    )),
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

Die Fehler wurden mit der Python-Bibliothek `uncertainties` berechnet.

== Histogramm

#figure(
    rotate(-90deg, image("Histogramm.jpg", width: 40%)),
    caption: [Histogramm zur Anzahl der Messungen für bestimmte Ladungen der
        Tröpfchen],
)<histogram>

== Systematischer Fehler

Wir haben manche Messungen über 10 Skalenteile durchgeführt, manche über 20. Da
wir den Fehler lieber überschätzen, gehen wir im Folgenden von 10 Skalenteilen
aus, also
$ s = qty("5.00+-0.13e-4", "m") $
Damit haben wir

$ (3 Delta s)/(2 s) = 0.039 $

Für die Öldichte nehmen wir an: $(Delta rho)/(rho) = 0.5 %$, für die Viskosität:
$(Delta eta)/eta = 0.2 %$. Für den Abstand der Kondensatorplatten haben wir:
$(Delta d)/d = 0.83%$ und für die Spannung $(Delta U)/U = 0.5%$.

Damit können wir den Systematischen Fehler abschätzen:

$
    (Delta q)_"sys"/q = sqrt(((3 Delta s)/(2 s))^2 + ((Delta rho)/(2 rho))^2 + ((3 Delta eta)/(2 eta))^2 + ((Delta d)/d)^2 + ((Delta U)/U)^2) = 6.4%
$


=== Herleitung der Fehlerformel
Zuerst drücken wir die Geschwindigkeiten $v_f$ und $v_s$ durch die Strecke $s$
und die Zeiten $t_f$ und $t_s$ aus:
$
    q & = (v_f + v_s) sqrt((9 dot v_f eta^3)/(2 rho g)) (6 pi d)/U \
      & = (s/t_f + s/t_s) sqrt((9 dot (s/t_f) eta^3)/(2 rho g)) (6 pi d)/U \
      & = s^(3/2)(1/t_f + 1/t_s) sqrt((9 dot (1/t_f) eta^3)/(2 rho g)) (6 pi d)/U \
$
Um den Fehler von $q$ abzuschätzen berechnen wir zunächst das totale
differential:

$
    dif q = (q / d) dif d - (q / U)dif U + (3/2 q / eta) dif eta - (1/2 q / rho) dif rho - (1/2 q/g) dif g + (3/2 q/s) dif s + (dots)dif t_f + (dots) dif t_s
$


Wir nehmen an, dass die Zeitmessung keinen systematischen Fehler sondern nur
statistischen Fehler hat, den wir später berücksichtigen werden. D.h. wir
vernachlässigen in dieser Berechnung die Terme $dif t_f$ und $dif t_s$.

Außerdem verwenden wir für $g$ einen Literaturwert, dessen Fehler im Verhältnis
zu den anderen vernachlässigt werden kann.

Wir haben also:

$
    (dif q)/q = (1 / d) dif d - (1 / U)dif U + (3/2 1 / eta) dif eta - (1/2 1 / rho) dif rho + (3/2 1/s) dif s
$

Nach den Regeln der Gausschen Fehlerfortpflanzung erhalten wir also:
$
    (Delta q)/q = sqrt(((3 Delta s)/(2 s))^2 + ((Delta rho)/(2 rho))^2 + ((3 Delta eta)/(2 eta))^2 + ((Delta d)/d)^2 + ((Delta U)/U)^2)
$



== Statistischer Fehler
Wir verwenden diese fünf Werte für $q$, die aus einem Tropfen berechnet wurden,
der fünfmal gemessen wurde:
$ q = [1.563,1.567,1.479,1.431,1.509] $
Mit `np.std(q, ddof=1)` können wir den Fehler einer Einzelmessung bestimmen:
$sigma_E = 0.058$. Dieser ist etwas kleiner als der in Excel berechnete Wert
$sigma_E' = 0.072$. Eine gewisse Abweichung ist aber zu erwarten, da Excel alle
Werte mit einbezieht, wir aber nur diese fünf Werte des einen Tropfens
betrachten.

Der Fehler des Mittelwerts ist damit:

$ sigma_M = sigma_E / sqrt(N) = sigma_E / sqrt(62) = 0.0073 $

Nach der Gausschen Fehlerfortpflanzung können wir den Fehler von $q$ berchnen:

$ (Delta q)/ q = sqrt(((Delta q_"sys")/q)^2 + sigma_M^2) = 6.4 % $

= Ergebnisse

#align(center, rect[
    $ "Elementarladung:" e = qty("1.46+-0.09e-19", "C") $
])
Statistische siginifikanz zum Literaturwert: $e' = qty("1.6022e-19", "C")$

$ z = abs(e' - e)/sqrt((Delta e')^2 + (Delta e)^2) = 1.52 $

= Diskussion



== Histogramm
In @histogram kann man sehr gut die Quantisierung der Ladung erkennen, da alle
sich Peaks in ähnlichem Abstand befinden (und keine Messwerte dazwischen
liegen).


== Obere Grenze für die Elementarladung

In der Excel-Tabelle war ein Schwellenwert von $hat(e) = qty("2.4e-19", "C")$
vorgegeben. Alle Messungen mit einer Ladung von $q < hat(e)$ wurden als Tropfen
mit genau einer Elementarladung klassifziert. Nun stellt sich die Frage, ob wir
sicher sein können, dass dieser Grenzwert korrekt ist.

An @histogram können wir ablesen, dass die kleinsten gemessenen Ladungen im
Bereich $qtyrange("1.2e-19", "1.6e-19", "C")$ sind. Wir können dadurch aber noch
nicht ausschließen dass diese Messungen Tropfen ein mit mehrern Elektronen
$q approx N dot e$ gemessen haben.

Eine genauere betrachtung des Histogramms ergibt allerdings, dass alle peaks in
einem Abstand von ca. $qty("1.5e-19", "C")$ liegen. D.h. es wäre sehr
unwahrscheinlich dass die erste Messung $q_1$ ein vielfaches der Elementarladnug
ist $q_1 = N dot e$, da alle anderen Messungen dann zufälligerweise auch
vielfache dieser Ladung sein müssten: $q_i = M dot N dot e$. Daraus können wir
schließen, dass die erste Messung Tropfen mit nur einem Elektron gemessen hat
und damit der Schwellenwert passend ist.






== Fehler

Der systematische Fehler ist mit $(Delta q)_"sys"/q = 6.4%$ fast um Faktor 10
größer als der statistische Fehler $sigma_M = 0.73 %$. Der systematische Fehler
überwiegt den statistischen Fehler also dramatisch.

#align(
    center,
    table(
        columns: 2,
        $(3 Delta s)/(2 s)$, num("0.039"),
        $(Delta rho)/(2 rho)$, num("0.0025"),
        $(3 Delta eta)/(2 eta)$, num("0.003"),
        $(Delta d)/d$, num("0.0083"),
        $(Delta U)/U$, num("0.005"),
    ),
)
Man sieht, dass hier die Unsicherheit der Fallstrecke am meisten zum
sytematischen Fehler beiträgt.

== Mögliche Fehlerquellen

Komisch dass (fast) alle einser kleine rals 1.6022 sind

Beschleunigung nicht berücksichtigt
