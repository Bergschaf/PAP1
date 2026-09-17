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
    title: "Schallgeschwindigkeit",
    versuch_nr: "26",
    authors: (
        (
            name: "Christian Krause",
            email: "christian.krause@stud.uni-heidelberg.de",
        ),
        (name: "Aaron Boheim", email: "aaron.boheim@stud.uni-heidelberg.de"),
    ),
    tutor: "Friederike Birgit Gehrke",
    date: "16.09.2026",
)

#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")


#set page(numbering: "1")


= Einleitung

#let co2 = $"CO"_2$
== Ziel
In diesem Versuch werden wir die Schallgeschwindigkeit in Luft und #co2 durch
die Abstände von Wellenäuchen bestimmen. Außerdem werden wir die
Schallgeschwindigkeit in Luft direkt über die Messung der Zeit nach einer
zurückgelegten Entfernung messen. TODO vlt geht das eleganter

== Physikalische Grundlagen

TODO

= Durchführung

TODO

= Protokoll

#figure(
    caption: [Versuchsprotokoll],
    stack(image("Protokoll.png"), image(
        "Protokoll_qualitativ.png",
        width: 50%,
    )),
)

= Auswertung
== Qunisches Rohr

Als erstes haben wir die Abstände zwischen unseren Messwerten für Luft und #co2
berechnet.

```py Abstände_Luft = [Messung_Luft[i] - Messung_Luft[i+1] for i in range(10)] ```
(analog für #co2) Daraus haben wir dann Mittelwert und den Fehler des
Mittelwerts (nach Formel TODO reference) berechnet:

$
    "Luft:"quad overline(d_L) = qty("7.15+-0.18e-2", "m") \
    co2 quad overline(d_co2) = qty("6.77+-0.03e-2", "m")
$

Wir wissen (TODO reference), dass der Abstand zweier Bäuche der Hälfte der
Wellenlänge entspricht, also $lambda = 2 dot d$.

Wir können nun (TODO reference zu z gleich lambda mal f) verwenden, um die
Schallgeschwindigkeit zu berechnen:

#figure(
    caption: [Schallgeschwindigkeit],
    table(
        columns: 4,
        [Medium],
        [Wellenlänge $lambda$ in m],
        [Frequenz $f$ in Hz],
        [Schallgeschwindigkeit $c = lambda dot f$ in $m/s$],

        [Luft], num("0.143+-0.004"), num("2401.0+-1.0"), num("343+-9"),
        co2, num("0.1356+-0.0006"), num("2005.0+-1.0"), num("271.8+-1.1"),
    ),
)
Den Fehler der Frequenz haben wir durch die Abweichung der Frequenz nach dem
Versuch im Vergleich zu vor dem Versuch abgeschätzt. TODO in Diskussion: Fehler
der Wellenlänge (Statistisch) hat größeren Einfluss. TODO Gaussche
Fehlerfortpflanzung, uncertainties package

Anschließend können wir nun Gleichung (TODO Referenz zu T und T_0 gleichung)
verwenden, um unsere gemessene Schallgeschwindigkeit auf Normalbedingungen
($T_0 = qty(0, "Ceclsius"))$) umzurechnen. Wir haben dafür die Temperatur des
Gases als $T = qty("24+-1", "Celsius")$ abgeschätzt, da die Raumtemperatur sich
im Laufe des Experiments leicht verändert hat.

$
    "Luft:" quad c_0_L = c_L dot sqrt(T_0/T) = qty("329+-8", "m/s") \
    co2 : quad c_0_co2 = c_co2 dot sqrt(T_0/T) = qty("260.6+-1.2", "m/")
$

== Berechnung der Schallgeschwindigkeit

Wir können (TODO formel referenz zu c = sqrt...) verwenden, um die
Schallgeschwindigkeit in Luft zu berechnen:

$ c_L = sqrt((kappa_L R T) / M_L) = qty("331.12", "m/s") $
$ c_co2 = sqrt((kappa_co2 R T) / M_co2) = qty("259.04", "m/s") $
mit den im Skript gegebenen Werten $kappa_L = 1.40$, $kappa_co2 = 1.30$,
$R approx 8.31446$, $T = T_0 = qty(273.15, "K")$, $M_L = qty(29, "g/mol")$ und
$M_co2 = qty(44, "g/mol")$.

== Verhältnisse

#figure(
    caption: [Verhältnisse der Schallgeschwindigkeiten],
    table(
        columns: 3,
        [], [Verhältnis $c_L/c_co2$], [Abweichung $z$],
        [Quinnsches Rohr],
        num("1.26+-0.03"),
        table.cell(rowspan: 2, align: horizon)[0.46],
        [Theoretische Berechnung], num("1.278"),
        table.vline(
            x: 2,
            start: 0,
            end: 3,
            stroke: 2pt,
        ),
    ),
)

Mit (TODO referenz zu gleichung c = sqrt(viele dinge)) erhält man:

TODO das ist schlecht
$ c_L / c_co2 = sqrt(kappa_L/M_L)/sqrt(kappa_co2/m_co2) = $
mit der Dichte $rho = kappa$

== Laufzeitmessung

Auch hier haben wir die Entfernungen zwischen den Höhenmessungen für unsere
beiden Messreihen bestimmt. Die Entfernung zwischen zwei Höhenmessungen
entspricht genau der Wellenlänge $lambda$, da sich die Wellen auf den wir
zwischen zwei Höhenmessungen die Daraus haben wir den Mittelwert und nach
(FORMEL TODO ) den Fehler des Mittelwerts berechnet:

$ overline(lambda) = qty("3.492+-0.018e-2", "m") $

Wir haben mit der Cursorfunktion des Oszilloskops eine Periodendauer
$T = num("101+-1")mu s$ gemessen, was einer Frequenz von
$f = 1/T = qty("9901+-98", "Hz")$ entspricht. Diese Messung über die
Periodendauer war aber nur eine Plausibilitätsprüfung, wir nehmen die
Einstellung des Frequenzgenerators auf $f = qty(10, "kHz")$ als gegeben an.

Mit (TODO GLeichung) erhalten wir eine Schallgeschwindigkeit von:

$ c = overline(lambda) dot f = qty("351.4+-1.4", "m/s") $
Auch hier rechnen wir die Schallgeschwindigkeit wieder auf Normalbedingungen um:
$ c_0 = c dot sqrt(T_0 / T) = qty("334.8+-1.8", "m/s") $


= Ergebnisse


Wir geben zur Einordnung die Abweichung zu den Literaturwerten
$ z(a_1,a_2) = abs(a_1 - a_2)/sqrt((Delta a_1)^2 + (Delta a_2)^2) $
an:

#figure(caption: [Schallgeschwindigkeitsmessung mit dem Quinnschen Rohr], table(
    columns: 5,
    [Messung], [Medium],
    [gemessene Schallgeschwindigkeit $c_0$ \ bei Normalbedingungen $c_0$ in
        $m/s$],
    [Literaturwert bei\ Normalbedingnugen in $m/s$],
    [Abweichung $z$],

    table.cell(rowspan: 2, align: horizon)[Quinnsches Rohr], co2,
    num("260.6+-1.2"),
    [#num("259") #footnote(
            "https://openstax.org/books/university-physics-volume-1/pages/17-2-speed-of-sound",
        )],
    $1.37$,
    table.cell(rowspan: 2, align: horizon)[Luft],
    num("329+-8"),
    table.cell(rowspan: 2, align: horizon)[#num("331.5") #footnote(
            "https://de.wikipedia.org/wiki/Schallgeschwindigkeit",
        )],
    $0.28$,
    [Laufzeitmessung], num("334.8+-1.8"), $1.86$,
))<res_quin>

#figure(
    caption: [Verhältnisse der Schallgeschwindigkeiten],
    table(
        columns: 3,
        [], [Verhältnis $c_L/c_co2$], [Abweichung $z$],
        [Quinnsches Rohr],
        num("1.26+-0.03"),
        table.cell(rowspan: 2, align: horizon)[0.46],
        [Theoretische Berechnung], num("1.278"),
        table.vline(
            x: 2,
            start: 0,
            end: 3,
            stroke: 2pt,
        ),
    ),
)




= Diskussion
== Quinsches Rohr
Man sieht in @res_quin, dass unsere Messwerte für die Schallgeschwindigkeit
innherhalb der Fehlerbereiche sehr gut mit den Literaturwerten übereinstimmen.

Der Fehler der Schallgeschwindigkeitsmessung in Luft ist ziemlich groß. Dazu
trägt hauptsächlich der statistische Fehler der Abstandsmessung bei. Um diesen
zu reduzieren könnte man natürlich mehr Messungen machen. Eine weitere
Möglichkeit wäre, die Höhenmessung genauer zu machen, z.B. mit einem
Laser-Entfernungsmesser, der die Wasseroberfläche misst. Aber auch die
justierung der Wasseroberfläche ist Fehlerbehaftet, da wir für das Audiosignal
eine sehr geringe Amplitude verwendet haben. Eine größere Amplitude hätte eine
genauere Einstellung ermöglicht (aber auch mehr Lärm verursacht).

== Verhältnisse








