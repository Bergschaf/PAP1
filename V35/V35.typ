#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
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
    title: "Fotoeffekt",
    versuch_nr: "35",
    authors: (
        (
            name: "Christian Krause",
            email: "christian.krause@stud.uni-heidelberg.de",
        ),
        (name: "Aaron Boheim", email: "aaron.boheim@stud.uni-heidelberg.de"),
    ),
    tutor: "Felix Maximilian Graf",
    date: "24.09.2026",
)

#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")


#set page(numbering: "1")


= Einleitung
== Ziel

Wir werden die Grenzenergie der beim Fotoeffekt emittierten Elektronen mit der
Gegenfeldmethode messen und darus das Planck'sche Wirkungsquantum $h$ bestimmen.

== Phyiskalische Grundlagen

#figure(
    image("Energieverteilung.png", width: 50%),
    caption: [Energieverteilung der Elektronen eines Metalls (Fermiverteilung)],
)<energieverteilung>
In @energieverteilung sieht man die Energieverteilung der Leitungselektronen
eines Metalls. Auf der $x$-Achse ist nach rechts die Energie aufgetragen, auf
der $y$-Achse sieht man die Wahrscheinlichkeit, dass sich ein Elektron in diesem
Energieniveau aufhält.

Bei $T = qty(0, "K")$ sind alle Energien bis zur Fermienerie $E_F$ besetzt,
darüber ist die Wahrscheinlichkeit, dass sich dort ein Elektron aufhält gleich
Null.

Bei einer Temperatur von $T > qty(0, "K")$ sind auch Energien oberhalb der
Fermienergie besetzt und einige Energien darunter sind unbesetzt.


#figure(
    image("Potenzialtopf.png", width: 50%),
    caption: [Potenzialtopfmodell],
)<pot>

In @pot sieht man die energetischen Verhältnisse schematisch dargestellt. Das
Elektron befindet sich im Metall auf einem Energieniveau von $E_e < E_F$. Die
Energie, die benötigt wird, um ein Elektron auf der Fermienergie $E_F$ zur
Außenwelt zu bringen bezeichnen wir als $A$. Wenn ein Photon mit der Energie
$h nu$ auf ein Leitungselektron mit der Energie $E_e$ trifft, wird dieses
ausgelöst und die restliche Energie bleibt als kinteische Energie $E_"kin"$
(vorrausgesetzt, dass $h nu > (E_F - E_e) + A$. Es gilt also:

$ h nu = A + (E_F - E_F) + E_"kin" $

Ein Elektron mit der Fermienergie $E_F$ kann die maximale kinetische Energie
$E_"kinmax"$ erreichen:

$ E_"kinmax" = h nu - A $

Diese maximale kinetische Energie kann durch die Messung der
Strom-Spannungskurve einer Fotozelle bestimmt werden.

#figure(
    image("Fotozelle.png", width: 50%),
    caption: [Fotozelle],
)<fotozelle>

@fotozelle Skizziert den Aufbau einer solchen Fotozelle. Die Kathode wird durch
eine dünne Kaliumschicht (mit geringer Austrittsarbeit) gebildet. Darüber
befindet sich die Anode in Form eines dünnen Drahtrings.

Zwischen Anode und Kathode liegt die Spannung $U$ an. Wenn das Potential der
Anode positiv ist, dann werden alle aus der Kathode ausgelösten Elektronen
"angesaugt" und erreichen die Anode.

Liegt allerdings eine negative Spannung an, dann können nur noch Elektronen
miteiner Kinetischen Energie $E_"kin" > abs(e dot U)$ die Anode erreichen. Bei
der Sperrspannung $U_S$ wird der Strom null.

#figure(
    image("Fotozelle_ideal.png", width: 60%),
    caption: [Strom- und Spannungskennlinie einer idealen Fotozelle],
)<ideal>
In @ideal sieht man die Strom und Spannungskennlinie einer idealen Fotozelle.
Bei einer Spannung von $U > 0$ ist der Fotostrom konstant, darunter sinkt er ab
bis zur Sperrspannung. Hat das Metall eine positive Temperatur $T > 0$, dann
sind auch Energieniveaus $E_e > E_F$ besetzt und manche Elektronen haben eine
kinetische Energie größer als die theoretische maximale kinetische Energie
$E_"kinmax"$.

#figure(
    image("Fotozelle_real.png", width: 60%),
    caption: [Strom- und Spannungskennlinie einer realen Fotozelle],
)<real>


In @real sieht man die Spannungsquelle einer realen Fotozelle. Es fällt auf,
dass der maximale Fotostrom nicht direkt bei $U = 0V$ erreicht wird. Das liegt
daran, dass die Geschwindigkeit der ausgelösten Elektronen nicht immer genau in
Richtung der Anode zeigt, in manchen Fällen wird eine Saugspannung $U > 0$
benötigt, um das Elektron umzulenken.

In unserem Versuchsaufbau ist außerdem zu beachten, dass $I$ proportional zu
$U^2$ ist (aufgrund der Geometrie von Anode und Kathode).

An der Sperrspannung $U_s$ gilt dann:
$ e U_s = E_"kinmax" = h nu - A prop sqrt(I) $

(Die Bilder stammen aus dem Skript).


= Protokoll

#figure(
    caption: [Messprotokoll],
    image("Messprotokoll.jpg"),
)
= Auswertung
Als erstes habe ich die gemessenen Spannungen $U_I$ mit der Untergrundspannung
$U_(I 0)$ korrigiert und daraus die Wurzel gezogen. Die Ergebnisse sind in den
nachfolgenden Tabellen aufgelistet.

Anschließend habe ich $sqrt(U_I - U_(I 0))$ als Funktion der Vorspannung
aufgetragen. An den linearen Teil habe ich eine Ausgleichsgerade mit
Fehlergeraden gelegt. Diese habe ich bis zur x-Achse gezogen um die
Sperrspannung $U_S$ zu bestimmen.


#figure(caption: [Messwerte für die UV-Linie], table(
    columns: 4,
    [Vorspannung $U$ in V],
    [Gemessene Spannung $U_I$ in V],
    [$U_i - U_(I 0)$ in V],
    [$sqrt(U_I - U_(I 0))$],

    num("-0.000+-0.010"),
    num("5.720+-0.024"),
    num("5.781+-0.024"),
    num("2.404+-0.005"),

    num("-0.100+-0.010"),
    num("5.210+-0.023"),
    num("5.271+-0.023"),
    num("2.296+-0.005"),

    num("-0.200+-0.010"),
    num("4.780+-0.022"),
    num("4.841+-0.022"),
    num("2.200+-0.005"),

    num("-0.300+-0.010"),
    num("4.320+-0.021"),
    num("4.381+-0.021"),
    num("2.093+-0.005"),

    num("-0.400+-0.010"),
    num("3.900+-0.020"),
    num("3.961+-0.020"),
    num("1.990+-0.005"),

    num("-0.500+-0.010"),
    num("3.488+-0.015"),
    num("3.549+-0.015"),
    num("1.884+-0.004"),

    num("-0.600+-0.010"),
    num("3.106+-0.013"),
    num("3.167+-0.013"),
    num("1.780+-0.004"),

    num("-0.700+-0.010"),
    num("2.717+-0.012"),
    num("2.778+-0.012"),
    num("1.667+-0.004"),

    num("-0.800+-0.010"),
    num("2.374+-0.010"),
    num("2.435+-0.011"),
    num("1.5605+-0.0034"),

    num("-0.900+-0.010"),
    num("2.036+-0.009"),
    num("2.097+-0.009"),
    num("1.4481+-0.0032"),

    num("-1.000+-0.010"),
    num("1.747+-0.008"),
    num("1.808+-0.008"),
    num("1.3447+-0.0030"),

    num("-1.100+-0.010"),
    num("1.465+-0.007"),
    num("1.526+-0.007"),
    num("1.2354+-0.0028"),

    num("-1.200+-0.010"),
    num("1.211+-0.006"),
    num("1.272+-0.006"),
    num("1.1279+-0.0026"),

    num("-1.300+-0.010"),
    num("0.967+-0.005"),
    num("1.028+-0.005"),
    num("1.0140+-0.0024"),

    num("-1.400+-0.010"),
    num("0.722+-0.004"),
    num("0.783+-0.004"),
    num("0.8849+-0.0022"),

    num("-1.500+-0.010"),
    num("0.4620+-0.0028"),
    num("0.5231+-0.0029"),
    num("0.7233+-0.0020"),

    num("-1.600+-0.010"),
    num("0.2642+-0.0012"),
    num("0.3253+-0.0012"),
    num("0.5704+-0.0011"),

    num("-1.700+-0.010"),
    num("0.1140+-0.0008"),
    num("0.1751+-0.0009"),
    num("0.4184+-0.0010"),

    num("-1.800+-0.010"),
    num("0.0152+-0.0005"),
    num("0.0763+-0.0006"),
    num("0.2762+-0.0012"),
))
#figure(
    caption: [$sqrt(U_I - U_(I 0))$ als Funktion der Vorspannung für die
        UV-Linie],
    image("Zeichnungen.pdf", page: 1),
)<fig1>

#figure(caption: [Messwerte für die violette Linie], table(
    columns: 4,
    [Vorspannung $U$ in V],
    [Gemessene Spannung $U_I$ in V],
    [$U_i - U_(I 0)$ in V],
    [$sqrt(U_I - U_(I 0))$],

    num("0.300+-0.010"),
    num("6.190+-0.025"),
    num("6.264+-0.025"),
    num("2.503+-0.005"),

    num("0.200+-0.010"),
    num("5.720+-0.024"),
    num("5.794+-0.024"),
    num("2.407+-0.005"),

    num("0.100+-0.010"),
    num("5.240+-0.023"),
    num("5.314+-0.023"),
    num("2.305+-0.005"),

    num("-0.000+-0.010"),
    num("4.780+-0.022"),
    num("4.854+-0.022"),
    num("2.203+-0.005"),

    num("-0.100+-0.010"),
    num("4.260+-0.021"),
    num("4.334+-0.021"),
    num("2.082+-0.005"),

    num("-0.200+-0.010"),
    num("3.840+-0.020"),
    num("3.914+-0.020"),
    num("1.978+-0.005"),

    num("-0.300+-0.010"),
    num("3.405+-0.015"),
    num("3.479+-0.015"),
    num("1.865+-0.004"),

    num("-0.400+-0.010"),
    num("2.972+-0.013"),
    num("3.046+-0.013"),
    num("1.745+-0.004"),

    num("-0.500+-0.010"),
    num("2.590+-0.011"),
    num("2.664+-0.011"),
    num("1.6321+-0.0035"),

    num("-0.600+-0.010"),
    num("2.209+-0.010"),
    num("2.283+-0.010"),
    num("1.5109+-0.0033"),

    num("-0.700+-0.010"),
    num("1.866+-0.008"),
    num("1.940+-0.008"),
    num("1.3927+-0.0030"),

    num("-0.800+-0.010"),
    num("1.557+-0.007"),
    num("1.631+-0.007"),
    num("1.2770+-0.0028"),

    num("-0.900+-0.010"),
    num("1.249+-0.006"),
    num("1.323+-0.006"),
    num("1.1501+-0.0026"),

    num("-1.000+-0.010"),
    num("0.958+-0.005"),
    num("1.032+-0.005"),
    num("1.0157+-0.0024"),

    num("-1.100+-0.010"),
    num("0.703+-0.004"),
    num("0.777+-0.004"),
    num("0.8813+-0.0022"),

    num("-1.200+-0.010"),
    num("0.4390+-0.0028"),
    num("0.5127+-0.0028"),
    num("0.7160+-0.0019"),

    num("-1.300+-0.010"),
    num("0.2290+-0.0011"),
    num("0.3027+-0.0011"),
    num("0.5502+-0.0010"),

    num("-1.400+-0.010"),
    num("0.0904+-0.0007"),
    num("0.1641+-0.0008"),
    num("0.4051+-0.0010"),

    num("-1.500+-0.010"),
    num("0.0012+-0.0005"),
    num("0.0749+-0.0006"),
    num("0.2737+-0.0011"),
))


#figure(
    caption: [$sqrt(U_I - U_(I 0))$ als Funktion der Vorspannung für die
        Violette Linie],
    image("Zeichnungen.pdf", page: 3),
)<fig2>
#figure(caption: [Messwerte für die Blaue Linie], table(
    columns: 4,
    [Vorspannung $U$ in V],
    [Gemessene Spannung $U_I$ in V],
    [$U_i - U_(I 0)$ in V],
    [$sqrt(U_I - U_(I 0))$],

    num("0.300+-0.010"),
    num("7.550+-0.029"),
    num("7.624+-0.029"),
    num("2.761+-0.005"),

    num("0.200+-0.010"),
    num("6.930+-0.027"),
    num("7.004+-0.027"),
    num("2.646+-0.005"),

    num("0.100+-0.010"),
    num("6.310+-0.026"),
    num("6.384+-0.026"),
    num("2.527+-0.005"),

    num("-0.000+-0.010"),
    num("5.740+-0.024"),
    num("5.814+-0.024"),
    num("2.411+-0.005"),

    num("-0.100+-0.010"),
    num("5.070+-0.023"),
    num("5.144+-0.023"),
    num("2.268+-0.005"),

    num("-0.200+-0.010"),
    num("4.490+-0.021"),
    num("4.564+-0.021"),
    num("2.136+-0.005"),

    num("-0.300+-0.010"),
    num("3.950+-0.020"),
    num("4.024+-0.020"),
    num("2.006+-0.005"),

    num("-0.400+-0.010"),
    num("3.433+-0.015"),
    num("3.507+-0.015"),
    num("1.873+-0.004"),

    num("-0.500+-0.010"),
    num("2.932+-0.013"),
    num("3.006+-0.013"),
    num("1.734+-0.004"),

    num("-0.600+-0.010"),
    num("2.421+-0.011"),
    num("2.495+-0.011"),
    num("1.5795+-0.0034"),

    num("-0.700+-0.010"),
    num("1.992+-0.009"),
    num("2.066+-0.009"),
    num("1.4373+-0.0031"),

    num("-0.800+-0.010"),
    num("1.578+-0.007"),
    num("1.652+-0.007"),
    num("1.2852+-0.0028"),

    num("-0.900+-0.010"),
    num("1.169+-0.006"),
    num("1.243+-0.006"),
    num("1.1148+-0.0025"),

    num("-1.000+-0.010"),
    num("0.754+-0.004"),
    num("0.828+-0.004"),
    num("0.9098+-0.0022"),

    num("-1.100+-0.010"),
    num("0.4190+-0.0027"),
    num("0.4927+-0.0027"),
    num("0.7019+-0.0019"),

    num("-1.200+-0.010"),
    num("0.1544+-0.0009"),
    num("0.2281+-0.0009"),
    num("0.4776+-0.0010"),

    num("-1.300+-0.010"),
    num("0.0022+-0.0005"),
    num("0.0759+-0.0006"),
    num("0.2755+-0.0011"),
))

#figure(
    caption: [$sqrt(U_I - U_(I 0))$ als Funktion der Vorspannung für die Blaue
        Linie],
    image("Zeichnungen.pdf", page: 2),
)<fig3>
#figure(caption: [Messwerte für die Grüne Linie], table(
    columns: 4,
    [Vorspannung $U$ in V],
    [Gemessene Spannung $U_I$ in V],
    [$U_i - U_(I 0)$ in V],
    [$sqrt(U_I - U_(I 0))$],

    num("0.300+-0.010"),
    num("4.200+-0.021"),
    num("4.229+-0.021"),
    num("2.057+-0.005"),

    num("0.200+-0.010"),
    num("3.577+-0.015"),
    num("3.606+-0.015"),
    num("1.899+-0.004"),

    num("0.100+-0.010"),
    num("2.985+-0.013"),
    num("3.014+-0.013"),
    num("1.736+-0.004"),

    num("-0.000+-0.010"),
    num("2.400+-0.011"),
    num("2.429+-0.011"),
    num("1.5586+-0.0034"),

    num("-0.100+-0.010"),
    num("1.804+-0.008"),
    num("1.833+-0.008"),
    num("1.3540+-0.0030"),

    num("-0.200+-0.010"),
    num("1.343+-0.006"),
    num("1.372+-0.006"),
    num("1.1715+-0.0027"),

    num("-0.300+-0.010"),
    num("0.895+-0.005"),
    num("0.924+-0.005"),
    num("0.9614+-0.0024"),

    num("-0.400+-0.010"),
    num("0.5410+-0.0032"),
    num("0.5703+-0.0032"),
    num("0.7552+-0.0021"),

    num("-0.500+-0.010"),
    num("0.2695+-0.0012"),
    num("0.2988+-0.0012"),
    num("0.5466+-0.0011"),

    num("-0.600+-0.010"),
    num("0.1059+-0.0008"),
    num("0.1352+-0.0009"),
    num("0.3677+-0.0012"),

    num("-0.700+-0.010"),
    num("0.0242+-0.0006"),
    num("0.0535+-0.0007"),
    num("0.2313+-0.0015"),
))

#figure(
    caption: [$sqrt(U_I - U_(I 0))$ als Funktion der Vorspannung für die Grüne
        Linie],
    image("Zeichnungen.pdf", page: 4),
)<fig4>

#figure(caption: [Messwerte für die Gelbe Linie], table(
    columns: 4,
    [Vorspannung $U$ in V],
    [Gemessene Spannung $U_I$ in V],
    [$U_i - U_(I 0)$ in V],
    [$sqrt(U_I - U_(I 0))$],

    num("0.300+-0.010"),
    num("1.177+-0.006"),
    num("1.191+-0.006"),
    num("1.0911+-0.0026"),

    num("0.200+-0.010"),
    num("0.832+-0.004"),
    num("0.845+-0.004"),
    num("0.9195+-0.0024"),

    num("0.100+-0.010"),
    num("0.5630+-0.0033"),
    num("0.5765+-0.0033"),
    num("0.7593+-0.0022"),

    num("-0.000+-0.010"),
    num("0.3560+-0.0024"),
    num("0.3695+-0.0025"),
    num("0.6079+-0.0020"),

    num("-0.100+-0.010"),
    num("0.1998+-0.0010"),
    num("0.2133+-0.0011"),
    num("0.4618+-0.0012"),

    num("-0.200+-0.010"),
    num("0.1108+-0.0008"),
    num("0.1243+-0.0009"),
    num("0.3526+-0.0013"),

    num("-0.300+-0.010"),
    num("0.0644+-0.0007"),
    num("0.0779+-0.0008"),
    num("0.2791+-0.0014"),

    num("-0.400+-0.010"),
    num("0.0425+-0.0006"),
    num("0.0560+-0.0008"),
    num("0.2366+-0.0016"),
))

#figure(
    caption: [$sqrt(U_I - U_(I 0))$ als Funktion der Vorspannung für die Gelbe
        Linie],
    image("Zeichnungen.pdf", page: 5),
)<fig5>


== Bestimmung der Planck Konstante

Anschließend habe ich die oben bestimmten Sperrspannungen $U_S$ als Funktion der
Frequenz der jeweiligen Spektrallinie aufgetragen:

#figure(
    caption: [Sperrspannung als Funktion der Frequenz],
    image("Zeichnungen.pdf", page: 6),
)<f_u>
In @f_u habe ich von Hand eine Ausgleichsgerade mit zwei Fehlergeraden durch den
Graphen gelegt. Damit erhalten wir eine Steigung von

$ m = qty("0.0062+-0.0014", "THz/V") $

Aus dieser Steigung können wir durch Multiplikation mit der Elementarladung $e$
das Planksche Wirkungsquantum berechnen: $h = m dot e$

#figure(
    caption: [Berechneter Wert und Literaturwert],
    table(
        columns: 4,
        [], [Berechneter Wert], [Literaturwert], [Abweichung $z$],
        [Planksches Wirkungsquantum $h$ [Js]],
        num("9.9+-2.3e-34"),
        num("6.62607e-34"),
        $1.4 sigma$,
    ),
)

Um den berechneten Wert mit dem Litearturwert zu vergleichen habe ich die
Abweichung
$ z = abs(h_1 - h_2)/sqrt((Delta h_1)^2 + (Delta h_2)^2) $
berechnet.


= Diskussion

== Diagramme

In @fig1, @fig2 und @fig3 fällt auf, dass der Verlauf nicht vollständig der
Theoretischen Erwartung entspricht (siehe @real). Ein Fehler bei der Berechnung
ist hier allerdings unwahrscheinlich, da @fig4 und @fig5 den erwarteten Verlauf
aufweisen. Dieser zeigt sich in einer Abweichung oberhalb der Ausgleichsgerade
für (betragsmäßig) große Vorspannungen und einer Abweichung unterhalb der
Ausgleichsgerade für (betragsmäßig) kleine Vorspannungen.

Eine mögliche Erklärung wäre ein nichtlinearer Fehler des Netzgeräts, der
insbesondere stark negtive Vorspannungen betrifft. Ein Indiz dafür ist, dass
@fig4 und @fig5, die den Erwarteten Verlauf aufweisen, beide mit in einem
(betragsmäßig) deutlich kleineren Bereich der Vorspannungen stattfinden (im
vergleich zu @fig1, @fig2 und @fig3).

Im Skript ist angegeben, dass wir aufgrund der Form der Anode die Wurzel aus der
korrigierten Spannung bilden sollen. Es könnte sein, dass diese Approximation in
unserem Fall zu ungenau war, z.B. durch leichte Abweichungen in unserem
Versuchsaufbau.

=== Verbesserungsmöglichkeiten

Um eine höhere Genauigkeit zu erziehlen könnte man eine Lichtquelle mit höherer
Intensität verwenden, was den Fotostrom erhöht und daher mit geringerem Fehler
messbar machen würde. Eine Möglichkeit wäre es, mehrere Laser mit verschiedenen
Wellenlängen anstelle der Spektrallinien der Quecksilberlampe zu verwenden.

Außerdem könnte man die Messung bei einer deutlich niedrigeren Temperatur (nahe
$T approx 0 K$) durführen. Dadurch würde der untere Teil der Spannungskurve eher
der idealen Form (siehe @ideal) entsprechen, was die Bestimmung der
Sperrspannung vereinfachen würde.

Weiterhin wäre es interessant, andere Anodenformen zu verwenden, wie zum
Beispiel ein Gitter. Dadurch könnte man überprüfen, ob die Form der Anode für
die Abweichung unserer Diagramme von der erwarteten Form verantwortlich ist.

== Planck Konstante

Unser berechneter Wert liegt mit einer Abweichung von $1.4 sigma$ im
Fehlerbereich des Literaturwerts. Hier ist allerdings zu beachten, dass unser
berechnete Wert einen sehr hohen prozentualen Fehler von ca. $23%$ aufweist.
Grund dafür ist die starke Streuung und die großen Fehler der Sperrspannungen.




