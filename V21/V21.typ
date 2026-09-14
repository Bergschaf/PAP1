#import "@preview/chemformula:0.1.3": ch
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
    title: "Elektrolyse",
    versuch_nr: "21",
    authors: (
        (
            name: "Christian Krause",
            email: "christian.krause@stud.uni-heidelberg.de",
        ),
        (name: "Aaron Boheim", email: "aaron.boheim@stud.uni-heidelberg.de"),
    ),
    tutor: "Caroline Niewa",
    date: "8.09.2026",
)

#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")


#set page(numbering: "1")


#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
= Einleitung

== Ziel

Das Ziel das Versuchs ist es, die Faraday-Konstante über zwei verschiedene Wege
zu bestimmen und elektrolyse qualitativ zu beobachten.

== Physikalische Grundlagen

=== Elektrolyse von Kupfersulfat

Kupfersulfat (#ch("CuSO4")) dissoziert folgendermaßen im Wasser:

$ #ch("CuSO4  <=> Cu^2+ + SO4^2-") $
Im ersten Versuchsteil verwenden wir zwei Kupferelektroden. Die #ch("Cu^2+")
Ionen wandern zur Kathode und werden dort durch die Aufnahme von zwei Elektronen
zu Kupfer reduziert. Dieses Kupfer lagert sich an der Kathode ab. An der Anode
wird währendessen Kupfer abgelöst und geht als #ch("Cu^2+") in Lösung.

Kupfer wandert also effektiv von der Anode zur Kathode.

Die an der Anode abgelöste Masse (bzw. an der Kathode angelagerte Masse) lässt
sich aus dem ersten Faraday'schen Gesetz bestimmen:

$ m = n dot M_"mol" = Q/(z F) M_"mol" $<eq_f>

mit der zwischen den Elektronen transportierten Ladung $Q$, der Molaren Masse
$M_"mol"$ von $Q$, der Wertigkeit $z$ der transportierten Ionen und der an der
Anode abgeschiedenen Stoffmenge $n$. Dabei bezeichnet
$F = e N_A = qty("9.64855+-0.00027e4", " C /mol")$ die Faraday-Konstante, die
wir später in den Versuchen bestimmen werden. Sie entspricht der Ladungsmenge,
die durch einen Elektrolyten fließt, wenn sich $1/z$ Mol eines z-wertiges
Stoffes an der Kathode absetzt (bzw. an der Anode ablöst).

=== Hoffmannscher Zersetzungsaperat
Der Zersetzungsapperat nach Hoffmann besizt zwei Schenkel mit jeweils einer
Platinelektrode und ein in der Höhe verschiebbares Vorratsgefäß mit verdünnter
Schwefelsäure.

Die Reaktion an den Elektroden lässt sich folgendermaßen erklären:

$
    "Kathode:" &&       #ch("4H+ + 4e- &-> 2H2") \
      "Anode:" && #ch("2H2O &-> 4H+ + O2 + 4e-")
$<gl1>


Wir können wieder @eq_f verwenden, um die Faraday-Konstante über das
abgeschiedene Volumen $V$ des Sauerstoffs bzw. Wasserstoffs zu bestimmen:

$ n = Q/(z F) quad "mit" n = V/V_"Mol" $<eq_f2>

Das Molare Volumen lässt sich mit dem idealen Gasgesetz abschätzen. Das
Molvolumen eines idealen Gases beträgt $V^0_"Mol" = qty("22.414", "l/mol")$
unter Normalvbedingungen ($T_0 = qty(273.15, "K")$,
$p_0 = qty(1013.25, "mbar")$). Bei einer anderen Temperatur $T$ und Druck $p$
gilt:

$ V_"Mol" = p_0/p T/T_0 V_"Mol"^0 V $<eq_mol>
Bei der Volumenmessung heben wir das Ausgleichsgefäß auf die Gleiche Höhe wie
die der Flüssigkeitsspiegel, der gerade abgelesen wird. Dadurch spielt der
hydrostatische Druck keine Rolle und der Druck $p$ setzt sich aus dem äußeren
Luftdruck $p_L$ und dem Dampfdruck $p_D$ der verdünnten Schwefelsäure zusammen.

$ p = p_L - P_D^#ch("H2SO4") = p_L - 0.9 P_D^#ch("H2O") $<eq_p>
Hier haben wir für den Sättungsdampfdruck des Elektrolyten $90%$ des
Sättungsdampfdrucks reinen Wassers eingesetzt (entspricht ca. $3%$
Schwefelsäure)

=== Brennstoffzelle

Eine Brennstoffzelle arbeitet nach dem umgekehrten Prinzip der Elektrolyse.
Während bei der Elektrolyse Wasser unter Energiezufuhr in Wasserstoff und
Sauerstoff zerlegt wird, reagieren diese Stoffe in der Brennstoffzelle unter
Abgabe von Energie wieder zu Wasser.

Im Versuch wird eine PEM-Brennstoffzelle verwendet. Diese besitzt zwei
Elektroden, die durch eine protonenleitfähige Membran voneinander getrennt sind.
Wasserstoff wird der Anode und Sauerstoff der Kathode zugeführt. An der Anode
wird Wasserstoff in Protonen und Elektronen aufgespalten. Die Protonen können
durch die Membran zur Kathode gelangen, während die Elektronen die Membran nicht
passieren können und über einen äußeren Stromkreis zur Kathode fließen. Dabei
kann ein Verbraucher mit elektrischer Energie versorgt werden. An der Kathode
reagieren schließlich Elektronen, Protonen und Sauerstoff zu Wasser.
= Durchführung

== Elektrolyse von Kupfersulfat

Zunächst wurde der obere Stromregler des Netzteils vollständig nach rechts
gedreht. Die eigentliche Einstellung der Stromstärke erfolgte anschließend
ausschließlich mit dem dem Schiebewiderstand.

Die beiden Kupferplatten wurden zunächst gründlich gereinigt, indem sie
geschmirgelt und mit Wasser gespült wurden. Anschließend wurden sie getrocknet
und möglichst genau gewogen. Danach wurden beide Kupferplatten in die
Kupfersulfatlösung eingetaucht.

Mit Hilfe des Schiebewiderstands wurde die Stromstärke auf $1 A$ eingestellt.
Die Stromstärke wurde während des Versuchs in Abständen von etwa einer halben
Minute kontrolliert und bei Bedarf nachreguliert. Die Elektrolyse wurde $30$
Minuten lang durchgeführt.

Am Ende haben wir die Elektrolyse durch Ausschalten des Netzteils beendet. Die
Kupferplatten wurden anschließend gründlich, aber vorsichtig mit Wasser gespült,
sodass kein angelagertes Kupfer entfernt wurde. Anschließend wurden die Platten
mit einem Fön getrocknet und erneut gewogen.

== Elektrolytische Zersetzung von Wasser

Zunächst wurden die beiden Schenkel des Hoffmannschen Wasserzersetzungsapparats
vollständig mit der Elektrolytlösung gefüllt. Dazu wurden die Hähne geöffnet und
das Vorratsgefäß langsam angehoben, bis der Flüssigkeitsspiegel etwas über den
Hähnen lag. Anschließend wurden die Hähne wieder geschlossen.

Der Wasserzersetzungsapparat haben wir ohne Schiebewiderstand direkt an das
Netzteil angeschlossen. Während eines kurzen Vorlaufs von etwa $30$ Sekunden
haben die Stromstärke auf einen festen Wert zwischen $0.5$ und $0.9 A$
eingestellt.

Nach dem Vorlauf haben wir gewartet, bis alle Gasbläschen aus der Flüssigkeit
aufgestiegen waren. Danach wurden beide Rohre wieder bis zum Hahn gefüllt.

Die Elektrolyse wurde so lange durchgeführt, bis der Wasserstoff die
entsprechende Röhre zu etwa $3/4$ gefüllt hatte. Die dafür benötigte Zeit wurde
gemessen. Während des Versuchs wurde die Stromstärke etwa jede Minute auf
Konstanz kontrolliert und gegebenenfalls nachreguliert bzw. für eine spätere
Mittelwertbildung notiert.

Anschließend wurden die Gasvolumina in beiden Rohren abgelesen. Dazu wurde das
Vorratsgefäß vorsichtig abgesenkt, bis der Flüssigkeitsspiegel im jeweiligen
Schenkel und im Vorratsgefäß auf gleicher Höhe standen. Dadurch wird der
hydrostatische Druckunterschied beseitigt und das Gasvolumen kann bei dem
entsprechenden äußeren Druck bestimmt werden.

= Protkoll
#image("Protokoll1.png")

#image("Protokoll3.png")

#figure(
    image("Protokoll2.png"),
    caption: [Versuchsprotokoll],
)

= Auswertung

== Elektrolyse von Kupfersulfat
Wir können @eq_f umformen zu:

$ F = Q/(z m) M_"mol" $

mit der an den Elektroden abgeschiedenen bzw. angelagerten Masse $m$. Die
transportierte Ladung $Q$ können wir über die Stromstärke $I$ und die vergangene
Zeit $t$ berechnen: $Q = I dot t$. Die Kupferionen sind zweiwertig $z = 2$.

#figure(
    table(
        columns: 3,
        [], [Massendifferenz $m$ in $g$], [Faraday Konstante $F$],
        [Anode], num("0.64110+-0.00014"), num("9.07+-0.10e4"),
        [Kathode], num("0.60440+-0.00014"), num("9.62+-0.11e4"),
    ),
    caption: [Werte für die Faraday Konsante],
)

Der Fehler der Wage beträgt $Delta m = qty("0.1", "mg")$, die Stromstärke
schwankte um ca. $Delta I = qty(0.01, "A")$. Bei der Zeitmessung ist uns ein
Fehler unterlaufen, da wir die Messung erst gestartet haben, nachdem wir den
Schiebewiderstand eingestellt hatten. Daher gehen wir von einer Unsicherheit der
Zeit von $Delta T = qty(10, "s")$ aus. Für die molare Masse von Kupfer verwenden
wir $M_"mol" = qty("64.546+-0.003", "g/mol")$.

Aus diesen Werte nhaben wir nach den Regeln der Gausschen Fehlerfortpflanzung
den Fehler der Faraday-Konstante berechnet. (Dafür haben wir das Python Package
`uncertainties` verwendet.)

== Elektrolytische Zersetzung von Wasser
=== Berechnung des molaren Volumens
Wir haben im Gang einen Luftdruck von $p_L = qty("10000.5+-0.2", "hPa")$
gemessen. Aus den Werten für die Raumtemperatur und die Temperatur im Reservoir
vor und nach dem Experiment schätzen wir eine Gastemperator von
$T_G = qty("27.0+-1.0", "Celsius")$.

Durch Einsetzen in @eq_mol erhalten wir ein Molares Volumen von:

$ V_"Mol" = qty("25.82+-0.10", "l/mol") $

=== Berechnung der Faraday Konstante

Aus dem Umgebungsluftdruck $p_L$ und dem Sättigungsdampfdruck von Wasser
$p_D = qty("37.8+-2.3", "mbar")$ können wir mit @eq_p den Druck des Wasserstoffs
bzw Sauerstoffs berechnen:

$ p = qty("966.5+-2.0", "mbar") $

Die Transportierte Ladung $Q$ können wir wieder aus der Stromstärke und der
vergangenen Zeit berechnen:

$ Q = I dot t = qty("340+-4", "C") $

Aus dem gemessenen Volumen von Sauerstoff $V_O_2$ und Wasserstoff $V_H_2$ können
wir die jeweiligen Stoffmengen berechnen. Aus @eq_f2 ergibt sich dann direkt die
Faraday Konstante:

#figure(
    table(
        columns: 3,
        [], [Stoffmenge $n = V/V_"Mol"$ in mol], [Faraday Konstante $F$],
        ch("O2"), num("8.83+-0.08e-4"), num("9.63+-0.14e4"),
        ch("H2"), num("1.78+-0.01e-3"), num("9.55+-0.12e4"),
    ),
)

Für den Sauerstoff verwenden wir hier eine Wertigkeit von $z = 4$, da bei der
Bildung, von einem #ch("O2") Molekül vier Elektronen entstehen. Wasserstoff hat
eine Wertigkeit von $z=2$, da zwei $H^+$ Ionen mit zwei Elektronen zu einem
$H_2$ Molekül reagieren.

= Ergebnisse

#figure(
    table(
        columns: 3,
        [Methode],
        [Faraday Konstante $F$ in $C " mol"^(-1)$],
        [Signifikanz $z$ der Abweichung zum Literaturwert],

        [Massenabnahme Anode], num("9.07+-0.10e4"), $5.60$,
        [Massenabnahme Kathode], num("9.62+-0.11e4"), $0.26$,
        [Volumen Sauerstoff], num("9.63+-0.14e4"), $0.12$,
        [Volumen Wasserstoff], num("9.55+-0.12e4"), $0.82$,
    ),
    caption: [Ergebnisse für die Faraday Konstante],
)

$ "mit" z(F) = abs(F - F_"lit")/sqrt((Delta F)^2 + (Delta F_"lit")^2) $
$F_"lit"$ bezeichnet hier den Literaturwert der Faraday-Konstante


= Diskussion

== Bestimmnug der Faraday-Konstante durch Massendifferenz
Der Wert der Faraday-Konstante, der durch die Massenabnahme an der Anode
berechnet wurde, ist um mehr als $5 sigma$ kleiner als der Literaturwert. Eine
mögliche Fehlerquelle wäre natürlich ein Fehler beim Wiegen des Start- oder
Endgewichts, zum Beispiel durch unsauberes Abtrocknen. Um den korrekten Wert für
die Faraday Konstante zu erreichen, hätte die gemessene Massendifferenz ca. um
#qty(0.04, "g") kleiner sein sollen. Es wäre auch möglich, dass sich zu viel
Masse abgelöst hat. An den Ecken und "ausgefransten" Seiten der Platte könnten
während des Experiemtns durch das auflösen des umgebenden Materials
Kupferstücken abgebrochen sein, ohne vollständig in Lösung zu gehen.

Der Wert, der durch die Massenabnahme der Kathode bestimmt wurde, stimmt
innerhalb des Fehlerbereichs mit der Faraday-Konstante überein. Hier wäre das
versehentliche Abwaschen des neu angelagerten Kupfers eine mögliche Fehlerquelle
gewesen.

== Bestimmung der Faraday-Konstante durch Volumenmessung

Beide Werte für die Faraday-Konstante stimmen innerhalb des Fehlerbereichs mit
dem Literaturwert überein. Eine mögliche Fehlerquelle beim Volumen des
Sauerstoffs ist die Reaktion von Sauerstoff mit Schwefelsäure zu
Perschwefelsäure. Außerdem ist die Berechnung über das Volumen des Wasserstoffs
theorethisch etwas genauer, da der Ablesefehler des Volumens weniger Einfluss
hat, da doppelt so viel Wasserstoff wie Sauerstoff erwartet wird.











