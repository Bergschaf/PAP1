#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")

#let project(
    title: "",
    versuch_nr: "",
    authors: (),
    tutor: "",
    date: "",
    body,
) = {
    // Metadaten
    set document(author: authors.map(a => a.name), title: title)

    // Seitenlayout
    set page(
        paper: "a4",
        margin: (left: 25mm, right: 25mm, top: 25mm, bottom: 25mm),
        numbering: "1 / 1",
        number-align: center,
    )

    // Schriftart und Textsatz
    set text(font: "New Computer Modern", size: 11pt, lang: "de")
    set par(justify: true, leading: 0.65em)
    set heading(numbering: "1.1")

    // Titelblatt / Kopfzeile
    align(center)[
        #text(weight: "bold", size: 16pt)[Physikalisches Anfängerpraktikum der
            Universität Heidelberg] \
        #v(1em)
        #text(weight: "bold", size: 22pt)[Versuch #versuch_nr]

        #text(weight: "bold", size: 22pt)[#title] \
        #v(2em)
    ]

    grid(
        columns: (2fr, 1fr),
        align(left)[
            *Durchführende(r):* \
            #authors.at(0).name (#authors.at(0).email) \
            #v(0.5em)
            *Partner(in):* \
            #authors.at(1).name
        ],
        align(right)[
            *Tutor(in):* \
            #tutor \

            *Datum der Durchführung:* #date \
        ],
    )

    v(3em)

    // Inhaltsverzeichnis
    outline(title: "Inhaltsverzeichnis", depth: 2)
    pagebreak()

    body
}
#show: project.with(
    title: "Schiefe Ebene",
    versuch_nr: "15",
    authors: (
        (
            name: "Christian Krause",
            email: "christian.krause@stud.uni-heidelberg.de",
        ),
        (name: "Aaron Boheim", email: "aaron.boheim@stud.uni-heidelberg.de"),
    ),
    tutor: "Tobias Rudolf",
    date: "4.09.2026",
)

#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")


#set page(numbering: "1")

#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")


#set page(numbering: "1")
= Einleitung

== Ziel

In diesem Versuch wollen wir die Beschleunigung von verschiedenen Zylindern auf
einer schiefen Ebene messen und mit der theorethischen Erwartung vergleichen.
Außerdem werden wir beobachten, wie viel der Potentiellen Energie der Zylinder
in kinetische Energie umgewandelt wird.
== Physikalische Grundlagen

=== Bewegungsgleichung
Man kann die Bewegungsgleichung eines Rollenden Zylinders mit Trägheitsmoment
$J$, Radius $R$ und Masse $m$ auf einer schiefen Ebene mit Neigungswinkel
$alpha$ leicht über Lagrange herleiten:

$ T = 1/2 dot m dot dot(x)^2 + 1/2 J (dot(x)/R)^2 $

$ V = - m g x sin(alpha) $

$ L = T - V $
$ (partial L)/(partial x) = m g sin(alpha) $
$
    dif/(dif t) (partial L)/(partial dot(x)) = m dot.double(x) + J/ R^2 dot.double(x)
$

$ dot.double(x) (m + J /R^2) - m g sin(alpha) = 0 $
$ dot.double(x) = m g sin(alpha)/(m + J/ R^2) $<a_s>

=== Vollzylinder
Um die Schwerpunktsbeschleunigung eines Vollzylinders auf der Schiefen Ebene zu
berechnen, benötigen wir zunächst das Trägheitsmoment:

$
    J_V = integral_0^R r_bot^2 dif m
    = integral_0^R r^2 rho 2 pi r h dif r
    = 2 pi rho h integral_0^R r^3 dif r
    = 1/2 pi rho h R^4
    = 1/2 m R^2
$

$ "Vollzylinder:" a_s = (m g sin(phi))/(3/2 m) $

=== Hohzylinder

Hier funktioniert die Herleitung analog:

$
    J_H = integral_(r_1)^(r_2) r^2 dif m
    = integral_(r_1)^(r_2) r^2 rho 2 pi r h dif r
    = 2 pi rho h integral_(r_1)^(r_2) r^3 dif r
    = 1/2 pi rho h (r_2^4 - r_1^4) \
    = 1/2 m (r_1^2 + r_2^2) quad "da" m = rho pi h (r_2^2 - r_1^2)
$


$ "Hohlzylinder": a_s = (m g sin(phi))/(m + 1/2 m (r_1^2 + r_2^2)/r_2^2) $


= Protokoll

#figure(
    image("Protokoll_V15.jpg"),
    caption: [Versuchsprotokoll],
)

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


Anschließend haben wir die Distanz als Funktion von $t^2$ geplotted und mit
`scipy.optimize.curve_fit` eine Ausgleichsgerade berechnet:

#figure(
    image("Plot_HZ.svg"),
    caption: [Distanz als Funktion von $t^2$ für den Hohlzylinder],
)<plot_hz>


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

Wie wir bereits in der Einleitung (siehe @a_s) festgestellt haben, gilt für die
Schwerpunktsbeschleunigung einer Rollbewegung auf einer schiefen Ebene:
$ a_s = (m g sin(phi)) / (m + I/(r^2)) $

=== Messung der benötigten Größen
Die Werte sind im Messprotokoll eintragen; Die Schieblehre hat einen Fehler von
$Delta d_S = qty(0.05, "mm")$ und die Wage hat einen Fehler von
$Delta m = qty(1, "g")$.Für $g$ haben wir den Referenzwert für Heidelberg aus
Versuch 14 übernommen: $g = qty(9.80984+-0.00002, "m/s^2")$

==== Berechnung des Winkels
Wie im Protokoll bereits skiziert haben wir die Höhe $h$ und Länge $l$ der Ebene
mit einer Genauigkeit von $qty(2, "mm")$ vermessen.#footnote[Die Messung war so
    ungenau, da es aufgrund der abgerundeten Holzkanten schwierig war, die
    Distanzen genau abzulesen.] Mit $tan phi = h/l$ ergibt sich ein
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
Um die Potentielle Energiedifferenz der Zylinder vor und nach der Bahn zu
berechnen, müssen wir zunächst den Höhenunterschied $Delta h$ berechnen:
#figure(
    image("berechnung_h.jpg"),
    caption: [Skizze zur höhenberechnung],
)
Man sieht in der Skizze, dass $Delta h = h_1 + h_2$. An dem blauen Dreieck sieht
man, dass $h_2 = r cos(alpha)$.

Um die zweite Höhe zu messen, haben wir den Abstand $d$ der Auflagepunkte der
Zylinder oben und unten gemessen (also die beiden rot eingezeichneten Kreise):
$d = qty("83.30+-0.1", "cm") + r$

Damit ergibt sich $h_2 = d sin(alpha) - r$ und:

$ Delta h = qty("0.1336+-0.0018", "m") $

Wir haben also alle Werte um die potentielle Energie zu berechnen:
$ E_"pot" = m g Delta h $

=== Kinetische Energie

Es gilt:

$
    E_"kin" = E_"trans" + E_"rot" = 1/2 m v^2 + 1/2 J omega^2 = 1/2 m v^2 + 1/2 J (v/R)^2
$

Aus den Zeitdifferenzen und dem Abstand der Lichtschranken (die auf dem ebenen
stück platizert waren) haben wir die Geschwindigkeiten der zylinder berechnet
und in die Formel eingesetzt.

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

    caption: [Beschleunigung der Zylinder],
)

== Energieerhaltung

#figure(
    table(
        columns: 4,
        [],
        [$E_"Pot"$],
        [$E_"kin"$],
        [Signifikanz der Abweichung von $E_"Pot"$ und $E_"kin"$],

        [Hohlzylinder],
        qty("0.581+-0.008", "J"),
        qty("0.529+-0.005", "J"),
        $5.45$,

        [Vollzylinder],
        qty("0.582+-0.008", "J"),
        qty("0.512+-0.005", "J"),
        $7.3$,
    ),
    caption: [Kinetische und Potentielle Energie der Zylinder],
)<energie>

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

Man sieht in @energie, dass die tatsächlich gemessene kinterische Energie nach
der Rampe für beide Zylinder siginifikant kleiner ist als die berechnete
potentielle Energie.

Das lässt sich dadurch erklären, dass während des Rollvorgangs potentielle
Energie in kinetische Energie umgewandelt wird. Dabei treten aber auch Verluste
auf, z.B. durch Roll- und Luftreibung (und das auftreffen auf der horizontalen
Ebene unten), die die potentielle Energie am Ende verringern.








