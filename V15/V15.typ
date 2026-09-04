
#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")


#set page(numbering: "1")
= Einleitung

Bewegungsgleichung:

$ T = 1/2 dot m dot dot(x)^2 + 1/2 J (R dot(x))^2 $

$ V = - m g x sin(alpha) $

$ L = T - V $
$ (partial L)/(partial x) = m g sin(alpha) $
$
    dif/(dif t) (partial L)/(partial dot(x)) = m dot.double(x) + J R^2 dot.double(x)
$


$ m dot.double(x) + J R^2 dot.double(x) - m g sin(alpha) = 0 $


== Beschleunigung des Schwerpunkt


== Fit

$ s = integral v(t) dif t = integral a dot t dif t = 1/2 * a * t^2 $

$ m_"fit" = s/t^2 = 1/2 * a $
$ a = 2 * m_"fit" $

== Servus
$ a_s = (m g sin(phi)) / (m + I/(r^2)) $<a_s>

=== Vollzylinder

$ I_V = 1/2 m r^2 $

$ "Vollzylinder:" a_s = (m g sin(phi))/(3/2 m) $

=== Hohzylinder

$ I_H = 1/2 m (r_1^2 + r_2^2) $

$ "Hohlzylinder": a_s = (m g sin(phi))/(m + 1/2 m (r_1^2 m + r_2^2)/r_2^2) $


= Auswertung

== Qualitative Untersuchung
Wenn man alle drei Körper gleichzeitig los schickt, kommt der Verbundzylinder
als erstes an, der Vollzylinder als zweites und der Hohlzylinder als drittes.

Diese Beobachtung stimmt auch mit @a_s überein, da die beschleunigung umgekehrt
proportional zum Trögheitsmoment ist (bei gleicher Masse). Da die Masse des
Verbundzylinders aufgrund des Messingkerns nahe der Drehachse konzentriert ist,
hat dieser das niedrigste Trägheitsmoment der drei Körper. Die Masse des
Hohlzylinders ist im Vergleich zu den anderen beiden deutlich weiter von der
Drehachse entfernt, was zu dem größten Trägheitsmoment führt.

== Bestimmung der Beschleunigung

Um die Beschleunigung zu bestimmen, haben wir die Lichtschranken in quadratisch
ansteigenden Abstand von oben platziert, um möglichst ähnliche Zeitintervalle zu
bestimmen.

TODO Tabelle mit abständen:

Anschließend haben wir die Distanz als Funktion von $t^2$ geplotted und mit
`scipy.optimize.curve_fit` eine Ausgleichsgerade berechnet:

#figure(
    image("Plot_HZ.svg"),
    caption: [Distanz als Funktion von $t^2$ für den Hohlzylinder],
)<plot_hz>

#figure(
    image("Plot_VZ.svg"),
    caption: [Distanz als Funktion von $t^2$ für den Vollzylinder],
)<plot_vz>

In den Diagrammen sind die Fehlerbalken in beide Richtungen zwar eingezeichnet,
aberschwer zu sehen, da wir für die Unsicherheit der Abstandsmessung von den
Lichtschranken $Delta d = qty(2, "mm")$ angenommen haben. Für die Unsicherheit
der Lichtschranke haben wir $Delta t = qty(3, "ms")$ angenommen, da die Skala
des Zeitmessgeräts zwar auf #qty(1, "ms") auflöst, wir aber auch noch von
Fehlern in der Lichtschranke und der Messelektronik ausgehen müssen. Die Fehler
von $t^2$ haben wir entsprechend der Gaußschen Fehlerfortpflanzung berechnet.

Für eine gleichmäßig beschleunigte Bewegung gilt
$ s = 1/2 a t^2 $
Die für die Steigung der Ausgleichsgerade $m_"fit"$ gilt:

$ m_"fit" = s/t^2 = a/2 $

Damit erhalten wir für die experimentell bestimmten Beschleunigungen $a_e$
(Zwischenwerte für $m_"fit"$ brauchen wir nicht angeben, durch zwei zu teilen
kriegen wir noch hin):

#rect[
    $ "Vollzylinder:" a_V_e = qty("0.953+-0.010", "m/s^2") $
    $ "Hohlzylinder:" a_H_e = qty("0.777+-0.010", "m/s^2") $
]
=== Berechnung der Beschleunigung

Wie wir bereits in der Einleitung (TODO Reference) festgestellt haben, gilt für
die Schwerpunktsbeschleunigung einer Rollbewegung auf einer schiefen Ebene:
$ a_s = (m g sin(phi)) / (m + I/(r^2)) $

=== Messung der benötigten Größen
Die Werte sind im Messprotokoll eintragen; Die Schieblehre hat einen Fehler von
$Delta d_S = qty(0.05, "mm")$ und die Wage hat einen Fehler von
$Delta m = qty(1, "g")$.Für $g$ haben wir den Referenzwert für Heidelberg aus
Versuch 14 übernommen: $g = qty(9.80984+-0.00002, "m/s^2")$

==== Berechnung des Winkels
Wie im Protokoll bereits skiziert haben wir die Höhe und Länge der Ebene mit
einer Genauigkeit von (TODO ???) vermessen. Daraus ergibt sich ein
Neigungswinkel von
$ phi = num("8.58+-0.11") "°" $

Die Fehler für die folgenden berechneten Beschleunigungen haben wir mit
gaußscher Fehlerfortpflanzung ermittelt:
=== Vollzylinder

$ I_V = 1/2 m r^2 $

#rect[$
    "Vollzylinder:" a_V_r = (m g sin(phi))/(3/2 m) = qty("0.975+-0.013", "m/s^2")
$]

=== Hohzylinder

$ I_H = 1/2 m (r_1^2 + r_2^2) $

#rect[$
    "Hohlzylinder": a_H_r = (m g sin(phi))/(m + 1/2 m (r_1^2 m + r_2^2)/r_2^2) = qty("0.800+-0.011", "m/s^2")
$]

In der Diskussion werden wir die Werte vergleichen.

== Energieerhaltung

=== Potentielle Energie
TODOOOO Fancy zeichnung für Höhenberechnung


=== Kinetische Energie

Es gilt:

$
    E_"kin" = E_"trans" + E_"rot" = 1/2 m v^2 + 1/2 J omega^2 = 1/2 m v^2 + 1/2 J (R v)^2
$


= Ergebnisse

== Beschleunigung
#figure(
    table(
        columns: 4,
        [],
        [Berechnete Beschleunigung $a_r$ in $m/s^2$],
        [Experimentell bestimmte Beschleunigung $a_e$ in $m/s^2$],
        [Signifikanz der Abweichung von $a_r$ und $a_e$],

        [Vollzylinder], num("0.975+-0.013"), num("0.953+-0.010"), [1.38],
        [Hohzylinder], num("0.800+-0.011"), num("0.777+-0.010"), [1.56],
    ),

    caption: [TODO],
)

== Energieerhaltung

TODO

= Diskussion
== Beschleunigung
Man sieht, dass die die experimentell bestimmte Beschleunigung in beiden Fällen
mit einer Sigifikanz von $1.5 sigma$ kleiner ist als die theorethisch erwartete
Beschleunigung.

Eine Ursache für diese Abweichung ist die Luftreibung, die wir in unserer
Berechnung nicht berücksichtigt haben. Das ist auch Konsistent damit, dass beide
experimentell bestimmten Werte kleiner als die berechneten Werte sind.

Wie wir bereits schon qualitiativ bemerkt haben, ist die Beschleunigung des
Hohlzylinders deutlich geringer als die des Vollzylinders.

== Energieerhaltung

TODO








