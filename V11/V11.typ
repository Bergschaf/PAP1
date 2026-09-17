
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
    title: "Einführungsversuch",
    versuch_nr: "11",
    authors: (
        (
            name: "Christian Krause",
            email: "christian.krause@stud.uni-heidelberg.de",
        ),
        (name: "Aaron Boheim", email: "aaron.boheim@stud.uni-heidelberg.de"),
    ),
    tutor: "Pham Huy Thang Le",
    date: "26.08.2026",
)

#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")


#set page(numbering: "1")

= Einleitung
== Ziel
Als erstes befassen wir uns damit, die Genauigkeit verschiedener Methoden zur
Bestimmung der Schwingsungsdauer eines Pendels zu vergleichen. Anschließend
bestimmen wir die Federkonstante des Pendels. Diese wird dann in einer zweiten
Messung verwendet, um die Erdbeschleunigung zu bestimmen.
== Physikalische Grundlagen

Für die Auslenkung $x$ eines Federpendels mit der Masse $m$ und der
Federkonstante $D$ gilt:
$ m dot.double(x) = - D x $
Eine partiukäre Lösung dieser DLG ist:
$ x(t) = x_0 cos(omega t) "mit" omega = sqrt(D/m) $
Wir wissen
$ omega = 2pi/T $
Dadurch erhalten wir:

$ T = 2 pi sqrt(m / D) $<glt>

Mit dieser Gleichung lässt sich die Federkonstante des Pendels bestimmen, wenn
man die Periodendauer als Funktion der Masse bestimmt.

Nach demm Hook'schem Gesetz gilt für die Auslenkung einer vertikalen Feder, an
der die Masse $m$ hängt:
$ m g = D x $<glg>
Dadurch lässt sich bei bekanntem $D$ durch die Messung von $x$ als Funktion von
$m$ die Erdbeschleunigung $g$ bestimmen.
= Protokoll


#figure(
    image("Protokoll.jpg"),
    caption: [Versuchsprotokoll],
)

= Auswertung

== Auswahl der Messmethode
Als erstes habe ich die ersten beiden Messreihen in ein Histogramm aufgetragen,
um zu bestimmen ob die Messung am maximum oder am Nulldurchgang genauer ist:

#figure(
    image("Histogramm_1.jpg", width: 50%),
    caption: [Messung am Maximum],
)<hist1>

#figure(
    image("Histogramm_2.jpg", width: 50%),
    caption: [Messung am Nulldruchang],
)<hist2>
=== Diskussion
Man sieht, bis auf den Ausreißer in @hist1, keinen großen Unterschied der
Verteilung zwischen den Histogrammen. Auffällig ist hingegen, dass hier ein
starker systematischer Fehler vorzuliegen scheint, der Mittelwert beider
Messungen unterscheidet sich signifikant. Dieser Fehler könnte daher kommen,
dass wir bei der Messung am Maximum direkt beim loslassen gestartet haben (wir
haben von 3 heruntergezält), während wir bei der Messung am Nulldurchgang am
ersten Nulldruchgang gestoppt haben. Dadurch ist das Loslassen bei der Messung
am Maximum vermutlich genau gleichzeitig passiert wie das Starten der Stoppuhr,
während bei der Messung am Nulldurchgang die Reaktionszeit ins Spiel kommt.

Dieser Fehler lässt sich leicht vermeiden, indem erst eine Periode abgewartet
wird, bevor die Messung gestartet wird. (Das haben wir dann in den
darauffolgenden Versuchen auch so gemacht.)

Bei der folgenden Messungen haben wir immer an der Ruhelage gestoppt, da das
Pendel dort mit maximaler Geschwindigkeit vorbeischwingt, während sich das
Vorzeichen der Geschwindigkeit sich am maximum ändert. Das Pendel verbringt also
deutlich weniger Zeit in der Nähe des Nulldruchgangs wie in der Nähe des
maximums. Dadurch ist der Zeitpunkt, an dem die Zeitmessung gestartet bzw.
gestoppt werden soll einfacher zu erkennen.

== Bestimmung der Federkonstante

Um die Federkonstante zu bestimmen, haben wir in einer Weiteren die
Periodendauer für verschiedenen Gewichte gemessen. Um den statistischen Fehler
abzuschätzen, haben wir für jedes Gewicht drei Messungen durchgeführt und davon
den Durchschnitt gebildet und den Fehler des Mittelwerts berechnet. Dieser viel
bei uns aber sehr klein aus. Da wir (laut Ansage unseres Tutors) keinen
zusätzlichen Fehler für die Reaktionszeit berechnet haben, sind unsere Fehler
sehr klein ausgefallen. Dadurch war es im folgenden Diagramm nicht möglich,
Fehlerbalken und eine Fehlergerade einzuzeichnen:
#figure(
    image("Diagramm_1.jpg", width: 50%),
    caption: [$T^2$ aufgetragen als Funktion der Masse $m$],
)

Aus der Steigung Regressionsgerade können wir mit @glt eine Federkonstante von
$ D = qty(2.95, "N/m") $
berechnen. Da wir die Reaktionszeit bei der Zeitmessung nicht berücksichtigt
habem ist eine Fehlerabschätzung hier schwierig.

== Bestimung der Erdbeschleunigung
In der nächsten Messreihe haben wir die Auslenkung der Feder als Funktion der
Masse gemessen und in einem Diagramm aufgetragen:

#figure(
    image("Diagramm_2.jpg", width: 50%),
    caption: [Auslenkung als Funktion des Gewichts],
)<fig2>


Auch in @fig2 ist die Fehlerabschätzung schwierig, da wir für die Auslenkung
wieder nur einen kleinen Fehler von $Delta s = qty(1, "mm")$ haben, der im
Diagramm nicht einfach einzuzeichnen ist. Daher können wir keine Fehlergerade
anlegen.

Aus der Steigung in @fig2 und der vorher bestimmten Federkonstante, können wir
mit @glg die Erdbeschleunigung berechnen:

#rect[$ g = D dot a = qty(9.6, "m/s^2") $]

= Diskussion
Der Wert für $g$ ist nahe an dem Literaturwert $g_"lit" = qty(9.81, "m/s^2")$.
Eine Fehlerabschätzung ist hier aber schwierig, da wir für beide
Regressionsgeraden keine sinnvolle Fehlergerade einzeichnen konnten.

Um einen sinnvollen Fehler abzuschätzen, müsste man für jedes Gewicht längere
Messreihen machen, sodass der statistische Fehler den Fehler durch die
Reaktionszeit besser abbilden kann. Außerdem müsste man ggf. den systematischen
Fehler der Zeitmessung abschätzen.

Weiterhin ignorieren wir viele mögliche Fehlerquellen, wie zum Beispiel
Luftreibung, die Masse der Feder und (möglicherweise) nichtlineares Verhalten
der Feder bei großen Auslenkungen.

