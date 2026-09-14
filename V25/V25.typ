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
    title: "Oszilloskop",
    versuch_nr: "25",
    authors: (
        (
            name: "Christian Krause",
            email: "christian.krause@stud.uni-heidelberg.de",
        ),
        (name: "Aaron Boheim", email: "aaron.boheim@stud.uni-heidelberg.de"),
    ),
    tutor: "Robin Rahner",
    date: "14.09.2026",
)

#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")


#set page(numbering: "1")

= Einleitung

== Ziel
Erstes Date mit dem Oszilloskop


== Physikalische Grundlagen

=== Funktionsweise des Oszilloskops

Oszilloskop ist toll

=== FFT

= Durchführung
TODO

= Protokoll

TODO

= Auswertung

== Signal 1 und 2

Wir haben Signal 1 und 2 mit der Cursorfunktion vermessen: #figure(
    table(
        columns: 4,
        [],
        [Spitze-Spitze Spannung $U_"SS"$ in $V$],
        [Gleichspannungsanteil $U_G$ in $V$],
        [Periodendauer $T$ in $s$],

        [Signal 1],
        num("1.020+-0.020"),
        num("0.530+-0.020"),
        num("4.96+-0.04e-3"),

        [Signal 2],
        num("108.0+-2.0e-3"),
        num("-2.210+-0.020"),
        num("3.100+-0.020e-3"),
    ),
    caption: [Werte von Signal 1 und 2],
)<table1>

In @sig1 sieht man, dass es sich bei Signal 1 um eine Rechteck-Welle handelt,
mit einem Zustand bei ca. $qty(0.02, "V")$ und einem bei ca. $qty("1.04", "V")$.
Man sieht an den abgerundeten Ecken, dass der Signalgenerator eine gewisse Zeit
benötigt, um die Spannung ein- bzw. auszuschalten. #figure(
    image("Signal_1.jpg", width: 50%),
    caption: [Signal 1],
)<sig1>

Wir haben Signal 2 zunächst mit der DC-Kopplung betrachtet: #figure(
    image("Signal_2_fern.jpg", width: 50%),
    caption: [Signal 2 (DC Modus)],
)<sig2_fern>
Man sieht in @sig2_fern, dass Signal 2 einen relativ großen
Gleichspannungs-Anteil hat. Um die Spitze-Spitze Spannung und die Periodendauer
genauer zu bestimmen, haben wir für die Messung dann zur AC-Kopplung gewechselt,
um die Werte in @table1 zu bestimmen:
#figure(
    image("Signal_2_nah.jpg", width: 50%),
    caption: [Signal 2 (AC Modus)],
)

Man sieht, dass dieses Signal sehr viel Rauschen enthält.

== Signal 3

Signal 3 fällt periodisch exponentiell ab und steigt wieder exponentiell an.

#figure(
    image("Signal_3.jpg"),
    caption: [Signal 3],
)
Hier haben wir im DC-Modus zunächst die Spitze-Spitze Spannung mit dem Cursor
gemessen:

$ U_"SS" = qty("968+-8", "mV") $

Anschließend haben wir die horizontale Skalierung erhöht und einen Cursor auf
den halben Wert von $U_"SS"$ platziert um die Halbwertszeit zu bestimmen:

$ T_(1/2) = qty("2.10+-0.10", "ms") $


== Signal 4

Bei Signal 4 handelt es sich um eine Schwebung, also die Überlagerung von zwei
Sinussignalen:
#figure(
    image("Signal_4.jpg", width: 50%),
    caption: [Signal 4],
)
Um die Frequenz des einhüllenden Signals $f_2$ zu bestimmen, haben wir im
AC-Modus mit der Cursorfunktion die Zeit von fünf halben Perioden des
einhüllenden Signals (von Nulldurchgang zu Nulldurchgang) gemessen:

$ f_2 = 5/2 dot qty("40.0+-0.08", "Hz") = qty("100+-3", "Hz") $

Anschließend haben wir mit einer größeren horizontalen Skalierung mit dem Cursor
die Frequenz über 10 Perioden der Schwingsfrequenz gemessen. Hier haben wir
darauf geachtet, bei den Nulldurchgängen von zwei Perioden zu messen, die nahe
eines Maximums der einhüllenden Frequenz liegen.

$ f_1 = 10 dot qty("158+-3", "Hz") = qty("1580+-30", "Hz") $

Dann haben wir in den `FFT`-Modus gewechselt, um die Frequenzen des
Schwebungssignals mit dem Cursor zu messen:

$
    f_I = qty("1394+-5", "Hz") \
    f_"II" = qty("1594+-5", "Hz")
$

Wir könnnen nun Gleichung (TODO Referenz verwenden), um aus den gemessenen
Schwebungsfrequenzen die einhüllende Frequenz und die Schwingungsfrequenz des
Signals zu messen:

$
    f_1 = 1/2 dot (f_"II" + f_I) = qty("1494+-3", "Hz") \
    f_2 = 1/2 dot (f_"II" - f_I) = qty("100+-3", "Hz")
$



TODO Gaussche Fehlerfortpflanzung, python package uncertainties

== PWM Signal
Die Helligkeit der LED wurde mit einem Potentiometer eingestellt, das mit einem
Microcontroller verbunden ist, der das PWM Signal moduliert. Am Ausgang 3 des
Signalgenerators haben wir dieses Signal für zwei verschiedene
Helligkeitseinstellungen des Potentiometers gemessen.

Zuerst haben wir Periodendauer, Pulsbreite und Pulshöhe mit dem Cursor bestimmt.
Anschließend haben wir dem `Measure`-Modus verwednet, um uns Effektivspannung
und mittlere Spannung anzeigen zu lassen.
#figure(
    table(
        columns: 3,
        [], [Dunkel], [Hell],
        [Periodendauer $T$ in ms], num("1030+-10"), num("1030+-10"),
        [Pulsbreite $t$ in $mu s$], num("110+-10"), num("860+-10"),
        [Pulshöhe $U_0$ in V], num("3.44+-0.04"), num("3.40+-0.04"),
        [Effektivspannung $U_"eff"$ in V],
        num("1.240+-0.010"),
        num("3.030+-0.010"),

        [Mittlere Spannung $U_M$], num("0.444+-0.003"), num("2.700+-0.010"),
    ),
    caption: [Messung des PWM Signals],
)

Wir können die Effektivspannung und die Mittlere Spannung mit (TODO Reference)
aus den ersten drei Werten auch manuell berechnen:

$
    "Dunkel:" quad & U_M = U_0 t/T = qty("0.37+-0.03", "V") \
      "Hell:" quad & U_M = U_0 t/T = qty("2.84+-0.05", "V")
$

$
    "Dunkel:" quad & U_"eff" = U_0 sqrt(t/T) = qty("1.12+-0.05", "V") \
      "Hell:" quad & U_"eff" = U_0 sqrt(t/T) = qty("3.11+-0.04", "V")
$


== Reflexionsmessung
Als letztes haben wir mit der Cursorfunktion die Zeit gemessen, in der sich in
einem langen Kabel ausbreitet und wieder reflektiert wird.

$
              "Offenes Ende:" & Delta t = qty("248+-4", "ns") \
    "Kurzgeschlossenes Ende:" & Delta t = qty("248+-4", "ns")
$
TODO phasensprung nd vergessen

Im Skript ist gegeben, dass die Ausbreitungsgeschwindigkeit der Pulse im Kabel
$66%$ der Vakuumlichtgeschwindigkeit beträgt. Mit
$c = qty("299 792 458", "m/s")$ können wir die Länge des Kabels berechnen:
$ s = 1/2 dot 0.66 dot Delta t = qty("24.6+-0.4", "m") $

Anschließend haben wir Ende des Kabels mit dem Widerstand verbunden und diesen
so eingestellt, dass die Reflektion der Pulse, die am Oszilloskop zu sehen war,
minimal war. Wir haben das Multimeter benutzt, um diesen Widerstand zu messen:

$ R = qty("54.20+-0.10", "Ohm") $
Hier haben wir die Ungenauigkeit des Multimeters, die wir online nachgeschlagen
haben, als Fehler verwendet.

Der tatsächliche Wellenwiderstand des Kabels vom Typ RG 58 beträgt
$R_K = qty("50+-2", "Ohm")$
#footnote[https://www.cabletech.com.hk/uploads/RG58CU.pdf].


= Diskussion


== Fehler bei Cursormessung

TODO immer ein Cursording

== Schwingungs- und Schwebungsfrequenz
TODO Abweichung z definieren #figure(
    table(
        columns: 4,
        [], [Gemessen], [Berechnet], [Abweichung $z$],
        [Schwingungsfrequenz $f_1$ in Hz],
        num("1580+-30"),
        num("1494+-3.5"),
        $2.9$,

        [Schwebungsfrequenz $f_2$ in Hz],
        num("100.00+-0.20"),
        num("100+-3"),
        $0$,
    ),
    caption: [Gemessene und berechnete Werte für Einhüllende- und
        Schwingungsfrequenz],
)<table_sch>

Man sieht in @table_sch, dass die gemessenen und berechneten Werte für die
Schwebungsfrequenz sehr genau übereinstimmen. Bei der Schwingungsfrequenz ist
die Abweichung etwas größer. Das könnte daran liegen, dass wir dort über einen
kleinen Zeitraum gemessen haben, weshalb die Ungenauigkeit des Oszilloskops
einen größeren Einfluss hat.



== PWM-Signal

#figure(
    table(
        columns: 4,
        [], [Gemessen], [Berechnet], [Abweichung $z$],
        [Dunkel: Mittlere Spannung $U_M$ in V],
        num("0.444+-0.003"),
        num("0.36+-0.04"),
        $2.26$,

        [Hell: Mittlere Spannung $U_M$ in V],
        num("2.700+-0.010"),
        num("2.84+-0.05"),
        $2.51$,

        [Dunkel: Effektivspannung $U_"eff"$ in V],
        num("1.240+-0.010"),
        num("1.12+-0.05"),
        $2.15$,

        [Hell: Effektivspannung $U_"eff"$ in V],
        num("3.030+-0.010"),
        num("3.11+-0.04"),
        $1.73$,
    ),
    caption: [Gemessene und berechnete Werte für Mittlere- und Effektivspannung
        der PWM-Signale],
)

Als erstes können wir feststellen, dass die Mittlere Spannung und die
Effektivspannung bei der helleren Einstellung der LED größer sind. Wir sehen,
dass bei allen vier Werten, der berechnete Wert innerhalb der Fehlerbereiche mit
dem gemessenen übereinstimmt.

== Reflexionsmessung

== Länge

Unsere gemessene Länge von $s = qty("24.6+-0.4", "m")$ stimmt innerhalb des
Fehlerbereichs mit der tatsächlichen Länge von #qty(25, "m") des Kabels überein.

TODO Reflektion war nd ganz minimal

== Widerstand
Die Abweichung des gemessenen Widerstands $R = qty("54.20+-0.10", "Ohm")$ vom
spezifizierten Widerstand des Kabels $R_K = qty("50+-2", "Ohm")$ beträgt
$ z = abs(R - R_K)/sqrt(R^2 + R_K^2) = 2.1 $
Beide Werte liegen also innerhalb ihres Fehlerbereichs.

Mögliche Fehlerquellen ist hier die geometrie des T-Stücks und des Kabels zum
Signalgenerator, welches auch einen Einfluss auf die Reflektion hat. Das sieht
man, da wir durch das Einstellen des Widerstands den Peak der Reflektion zwar
verkleinern können, aber nicht ganz auslöschen, es ist immernoch Reflektion zu
sehen.

