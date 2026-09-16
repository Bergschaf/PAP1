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



= Einleitung

== Ziel
In diesem Versuch werden wir das Oszilloskop kennenlernen und seine wichtigsten
Funktionen zur Messung elektrischer Signale anwenden. Dazu werden verschiedene
Signale hinsichtlich ihrer Periodendauer, Frequenz und Amplitude untersucht.
Außerdem werden wir ein PWM-Signal zur Dimmung einer LED betrachten und die
Frequenzanteile eines Schwebungssignals mit einer Fourier-Transformation
bestimmen. Abschließend untersuchen wir die Reflexion eines Signals an einem
Kabel und bestimmen daraus die Länge und den Wellenwiderstand des Kabels.

== Physikalische Grundlagen

=== Funktionsweise des Oszilloskops
Wir verwenden ein digitales Speicheroszilloskop. Dabei wird die Eingangsspannung
mit einem Analog-Digital-Wandler in festen Zeitabständen abgetastet und die
Messwerte in einem Speicher abgelegt. Anschließend werden die gespeicherten
Werte auf dem Display dargestellt. Dadurch können neben periodischen Signalen
auch einmalige oder sehr kurze Signalverläufe aufgezeichnet und später
betrachtet werden.

Im $y t$-Betrieb wird die Spannung auf der vertikalen Achse und die Zeit auf der
horizontalen Achse dargestellt. Die Zeitauflösung wird über die horizontale
Skalierung eingestellt, während die vertikale Skalierung die dargestellte
Spannung pro Division festlegt. Für eine möglichst genaue Messung sollte das
Signal dabei einen möglichst großen Bereich des Bildschirms ausfüllen.

=== Triggerung
Damit ein periodisches Signal auf dem Bildschirm als stehendes und stabiles Bild
erscheint, muss die Aufnahme mit dem Signal synchronisiert werden. Dies
geschieht durch die Triggerung. Das Oszilloskop beginnt die Aufnahme dabei erst,
wenn das Signal einen vorgegebenen Triggerlevel erreicht. Zusätzlich kann
festgelegt werden, ob auf eine steigende oder fallende Flanke getriggert werden
soll. Dadurch wird bei jeder Aufnahme derselbe Signalausschnitt dargestellt.

=== Eingangskopplung
Für die Eingangskopplung stehen die Einstellungen DC, AC und Erde zur Verfügung.
Bei der DC-Kopplung wird das gesamte Eingangssignal einschließlich eines
möglichen Gleichspannungsanteils dargestellt. Die AC-Kopplung filtert den
Gleichspannungsanteil heraus, sodass nur die zeitlich veränderliche
Wechselspannung betrachtet wird. Bei der Erde-Einstellung wird der Eingang auf
Masse gelegt. Dadurch kann die Nulllinie des Kanals eingestellt werden.

=== Cursormessung und automatische Messungen
Mit der Cursorfunktion können verschiedene Größen eines Signals direkt auf dem
Bildschirm bestimmt werden. Je nach Einstellung können beispielsweise
Zeitdifferenzen, Periodendauern oder Spannungsdifferenzen gemessen werden.
Zusätzlich besitzt das Oszilloskop eine automatische Messfunktion, mit der
verschiedene Signalgrößen direkt berechnet und angezeigt werden können. Für eine
möglichst geringe Ableseunsicherheit sollte das Signal bei Cursormessungen
möglichst groß auf dem Bildschirm dargestellt werden. Der Fehler der
Cursormessung lässt sich durch die Größe eines Cursorschritts abschätzen.


=== Pulsweitenmodulation
Bei der Pulsweitenmodulation (PWM) wird eine Spannung zwischen zwei
Spannungswerten umgeschaltet. Die Helligkeit der LED wird dabei nicht durch eine
Änderung der Spannungshöhe, sondern durch das Verhältnis von Pulsdauer $t$ zur
Periodendauer $T$ verändert. Dieses Verhältnis wird als Tastgrad bezeichnet.

Für eine Pulshöhe $U_0$ ergeben sich für die mittlere Spannung und den
Effektivwert

$ U_M = U_0 t/T $<glm>

und

$ U_"eff" = U_0 sqrt(t/T). $<gle>

Ein größerer Tastgrad führt somit zu einer größeren mittleren Spannung und einer
größeren Effektivspannung und damit zu einer höheren Helligkeit der LED.

=== Fourier-Transformation
Mit einer Fourier-Transformation kann ein zeitabhängiges Signal in seine
Frequenzanteile zerlegt werden. Das Oszilloskop verwendet dazu die Fast Fourier
Transformation (FFT). Im Frequenzbereich wird auf der horizontalen Achse die
Frequenz dargestellt. Bei einer Schwebung, die aus der Überlagerung zweier
Sinussignale entsteht, treten zwei charakteristische Frequenzen auf. Aus diesen
können die Schwingungsfrequenz und die Schwebungsfrequenz bestimmt werden.

=== Wellenwiderstand und Reflexion
Bei der Ausbreitung eines elektrischen Signals auf einer Leitung können an
Stellen mit geändertem Wellenwiderstand Reflexionen auftreten. Der
Wellenwiderstand einer Leitung hängt von ihrer Geometrie und ihrem Material ab
und ist gegeben durch

$ Z = sqrt(L'/C'), $

wobei $L'$ die Induktivität und $C'$ die Kapazität pro Länge der Leitung sind.

Am Ende einer Leitung hängt die Reflexion von deren Abschluss ab. An einem
offenen Ende wird ein Puls ohne Phasensprung reflektiert, während sich bei einem
kurzgeschlossenen Ende die Polarität des reflektierten Pulses umkehrt. Ist der
Abschlusswiderstand gleich dem Wellenwiderstand der Leitung, tritt keine
Reflexion auf. Durch die Laufzeit des reflektierten Pulses kann außerdem die
Länge des Kabels bestimmt werden.


In der Einleitung wurde KI als Formulierungshilfe eingesetzt.
= Durchführung

== Vermessung der gegebenen Signale

Zuerst wurde das Oszilloskop eingeschaltet und für die Messungen vorbereitet.
Dazu wurde die Eingangsspannung zunächst auf Erde gestellt und die Nulllinie
eingestellt. Anschließend wurde der Eingang wieder auf DC geschaltet. Für die
Messungen wurde der passende Spannungs- und Zeitmaßstab gewählt und das Signal
mit der Triggerung stabil auf dem Bildschirm dargestellt.

Anschließend wurden die vier vorgegebenen Signale mit dem Oszilloskop
untersucht. Dabei wurden jeweils mit dem Cursor die für das Signal relevanten
Größen bestimmt.

Beim vierten Signal wurde zusätzlich die Fourier-Transformation des Signals
betrachtet. Dabei wurde das Frequenzspektrum auf dem Display dargestellt und die
enthaltenen Frequenzanteile mit dem Cursor abgelesen.

== Pulsweitenmodulation

Als nächtes wurde ein PWM-Signal zur Dimmung einer LED untersucht. Die
Intensität der LED wurde dabei über das Tastverhältnis des PWM-Signals
verändert. Für zwei verschiedene Intensitäten wurde das Signal mit dem
Oszilloskop aufgenommen und das Verhältnis von Pulsdauer $t$ zur Periodendauer
$T$ bestimmt.

Aus den Messwerten wurden anschließend die mittlere Spannung und die effektive
Spannung des PWM-Signals bestimmt.

== Reflexion am Kabel

Zum Schluss wurde die Reflexion eines Signals am Ende eines Kabels untersucht.
Dazu wurde ein Signal auf die Leitung gegeben und das am Kabelende reflektierte
Signal mit dem Oszilloskop beobachtet. Die Messung wurde für verschiedene
Abschlussbedingungen (offen und geschlossen) durchgeführt. Anschlie0end wurde
ein Widerstand am Ende des Kabels so eingestellt, dass die Reflektion minimal
war. Dieser Widerstand wurde dann mit dem Multimeter gemessen.

= Protokoll

#show figure: set block(breakable: true)
#figure(caption: [Versuchsprotokoll], align(center, grid(
    columns: 2,
    gutter: 2em,
    image("Protokoll.pdf", page: 1, width: 70%),
    image("Protokoll.pdf", page: 2, width: 70%),

    image("Protokoll.pdf", page: 3, width: 70%),
    image("Protokoll.pdf", page: 4, width: 70%),

    image("Protokoll.pdf", page: 5, width: 70%),
    image("Protokoll.pdf", page: 6, width: 70%),
)))
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

Wir könnnen nun aus den gemessenen Schwebungsfrequenzen die einhüllende Frequenz
und die Schwingungsfrequenz des Signals berechnen:

$
    f_1 = 1/2 dot (f_"II" + f_I) = qty("1494+-3", "Hz") \
    f_2 = 1/2 dot (f_"II" - f_I) = qty("100+-3", "Hz")
$


Wir haben die Fehler für alle Rechnungen mit gaußscher Fehlerfortpflanzung
berechnet. Dabei hat uns das Python Package `uncertainties` geholfen.

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

Wir können die Effektivspannung und die Mittlere Spannung mit @gle und @glm aus
den ersten drei Werten auch manuell berechnen:

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
Bei dieser Messung ist aufgefallen, dass die Spannung der reflektion beim
offenen Ende gleich gepolt war wie die des Pulses, beim geschlossenen Ende
allerdings umgekehrt.

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

Bei der Messung mit dem Cursor haben wir den Fehler immer mit einen
Cursorschritt abgeschätzt. Wir wissen nicht wie genau diese Abschätzung ist, da
wir mögliche Systematische Fehler des Geräts nicht kennen.

Bei der Messung mit dem Measure Mode haben wir den Fehler durch die Schwankung
der letzten Ziffer abgeschätzt (falls diese geschwankt hat). Auch hier ist es
schwierig zu beurteilen, wie genau diese Abschätzung ist, da wir die Fehler der
`M̀EASURE`-Funktion des Oszilloksops nicht kennen.

== Schwingungs- und Schwebungsfrequenz
Um die gemessenen und berechneten Werte zu vergleichen, haben wir (auch für die
weiteren Auswertung) die abweichung zweier Größen berechnet:
$ z(a_1, a_2) = abs(a_1 -a_2)/sqrt((Delta a_1)^2 + (Delta a_2)^2) $
#figure(
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

== Widerstand
Die Abweichung des gemessenen Widerstands $R = qty("54.20+-0.10", "Ohm")$ vom
spezifizierten Widerstand des Kabels $R_K = qty("50+-2", "Ohm")$ beträgt
$ z = abs(R - R_K)/sqrt(R^2 + R_K^2) = 2.1 $
Beide Werte liegen also innerhalb ihres Fehlerbereichs.

Mögliche Fehlerquellen ist hier die Geometrie des T-Stücks und des Kabels zum
Signalgenerator, welches auch einen Einfluss auf die Reflektion hat. Das sieht
man, da wir durch das Einstellen des Widerstands den Peak der Reflektion zwar
verkleinern können, aber nicht ganz auslöschen, es ist immernoch Reflektion zu
sehen.

