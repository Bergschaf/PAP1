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
    title: "Temperaturmessung",
    versuch_nr: "41",
    authors: (
        (
            name: "Christian Krause",
            email: "christian.krause@stud.uni-heidelberg.de",
        ),
        (
            name: "Alois Bachmann",
            email: "alois.bachmann@stud.uni-heidelberg.de",
        ),
    ),
    tutor: "Rebekka Kirchgässner",
    date: "30.9.2026",
)

#set page(numbering: "1")

= Einleitung

== Ziel des Versuchs

Ziel des Versuchs ist es, verschiedene Verfahren zur Temperaturmessung zu
untersuchen und miteinander zu vergleichen. Dazu wird zunächst ein
Gasthermometer anhand bekannter Temperaturpunkte geeicht. Mit der daraus
bestimmten Eichgeraden werden anschließend Temperaturen im Bereich von #qty(
    0,
    "Celsius",
) bis #qty(100, "Celsius") sowie die Temperatur von flüssigem Stickstoff und
Trockeneis bestimmt. Außerdem wird die Temperaturabhängigkeit des elektrischen
Widerstands eines Pt100-Widerstandsthermometers untersucht. Abschließend werden
die mit einem Infrarot-Pyrometer gemessenen Temperaturen mit den Werten des
Gasthermometers verglichen.

== Physikalische Grundlagen

Die Temperatur eines Körpers lässt sich mithilfe verschiedener
temperaturabhängiger physikalischer Größen bestimmen. In diesem Versuch werden
der Gasdruck, der elektrische Widerstand und die abgegebene Wärmestrahlung zur
Temperaturmessung verwendet.

Das Gasthermometer basiert auf der idealen Gasgleichung

$ p V = N k T, $

wobei $p$ den Druck, $V$ das Volumen, $N$ die Teilchenzahl, $k$ die
Boltzmann-Konstante und $T$ die absolute Temperatur bezeichnet. Bei konstantem
Volumen und gleichbleibender Teilchenzahl ist der Druck proportional zur
absoluten Temperatur:

$ p prop T. $

Daher kann aus dem gemessenen Druck auf die Temperatur geschlossen werden. Dazu
wird das Gasthermometer mithilfe bekannter Temperaturpunkte geeicht. Für den
Siedepunkt des Wassers muss der gemessene Druck auf Normalbedingungen
umgerechnet werden, da die Siedetemperatur vom Umgebungsdruck abhängt. Es gilt

$ p_"NB" = p_"gem" * (1013.25 "hPa") / p_"LD", $

wobei $p_"gem"$ den gemessenen Gasdruck und $p_"LD"$ den gemessenen Luftdruck
bezeichnet. $p_"NB"$ ist der auf den Normaldruck von $1013.25 "hPa"$
umgerechnete Druck. Durch die Auftragung der Eichpunkte in einem
Druck-Temperatur-Diagramm kann eine Eichgerade bestimmt werden. Ihre
Extrapolation auf den Druck $p = 0$ ermöglicht eine experimentelle Abschätzung
des absoluten Nullpunkts.

Ein weiteres Messverfahren ist das Platin-Widerstandsthermometer. Dessen
elektrischer Widerstand hängt von der Temperatur ab und lässt sich im
betrachteten Bereich durch ein Polynom zweiten Grades beschreiben:

$ R(T) = R_0 (1 + A T + B T^2). $

Dabei ist $R_0$ der Widerstand bei #qty(0, "Celsius"), während $A$ und $B$
materialabhängige Koeffizienten sind. Für ein Pt100-Thermometer gilt
$R_0 = 100 Omega$, $A = 3.9083 * 10^(-3) "°C"^(-1)$ und
$B = -5.775 * 10^(-7) "°C"^(-2)$. Im Temperaturbereich von #qty(0, "Celsius")
bis #qty(100, "Celsius") ist der quadratische Term vergleichsweise klein, sodass
näherungsweise ein linearer Zusammenhang zwischen Widerstand und Temperatur
erwartet wird.

Zur Widerstandsmessung wird in der Vierleiterschaltung ein konstanter Strom
$I_m$ durch das Pt100-Element geleitet und die Spannung $U$ gemessen. Aus dem
ohmschen Gesetz ergibt sich der Widerstand zu

$ R = U / I_m. $

Die verwendete Vierleiterschaltung reduziert dabei den Einfluss der
Leitungswiderstände auf die Messung.

Das Infrarot-Pyrometer bestimmt die Temperatur berührungslos anhand der von
einem Körper ausgesandten Wärmestrahlung. Die theoretische Grundlage bildet das
Plancksche Strahlungsgesetz, das die spektrale Verteilung der Wärmestrahlung in
Abhängigkeit von der Temperatur beschreibt. Für einen idealen schwarzen
Strahler, der sämtliche einfallende Strahlung absorbiert, ist die gesamte
abgestrahlte Leistung durch das Stefan-Boltzmann-Gesetz gegeben:

$ P = epsilon sigma A T^4. $

Hierbei bezeichnet $epsilon$ das Emissionsvermögen, $sigma$ die
Stefan-Boltzmann-Konstante und $A$ die abstrahlende Fläche. Für einen idealen
schwarzen Strahler gilt $epsilon = 1$. Reale Körper können dagegen einen Teil
der einfallenden Strahlung reflektieren und besitzen daher im Allgemeinen ein
geringeres Emissionsvermögen. Dies kann zu Abweichungen zwischen der vom
Pyrometer angezeigten und der tatsächlichen Temperatur führen.

Für diese Einleitung wurde KI als Formulierungshilfe eingesetzt.

#pagebreak()
= Versuchsprotokoll

#show figure: set block(breakable: true)
#figure(
    stack(
        image("Versuchsprotokoll.pdf", page: 1, width: 80%),
        image("Versuchsprotokoll.pdf", page: 2, width: 80%),
        image("Versuchsprotokoll.pdf", page: 3, width: 80%),
        image("Versuchsprotokoll.pdf", page: 4, width: 80%),
    ),
    caption: [Versuchsprotokoll],
)

= Auswertung


== Eichung des Gastherometers

TODO bissle labern mit dem einen Wert auf normalbedingnugen berechnet

#figure(
    image("zwei_eichpunkte.svg"),
    caption: [Eichgerade mit zwei Eichpunkten],
)<figzwei>

Wenn wir die Gerade in @figzwei weiterziehen, erhalten wir einen Nullpunkt von
$T_0 = qty("-268", "Celsius")$. Eine Fehlerabschätzung ist hier schwierig, da
keine sinnvolle Fehlergerade eingezeichnet werden kann, da der Fehler der
Druckmessung sehr klein ist.

Im Flüssigen Stickstoff haben wir einen Druck von
$p_N = qty("255.0+-1.0", "hPa")$ gemessen. Aus dem Diagramm erhält man damit
eine Temperatur von $T_N_1 = qty(-194.4, "Celsius")$.

Dieser Wert ist sehr nah (TODO besser) am Literaturwert
$T_N_"lit" = qty(-195.8, "Celsius")$.

Wenn wir den Literaturwert als weiteren Eichpunkt verwenden, erhalten wir:

#figure(
    image("drei_eichpunkte.svg"),
    caption: [Eichgerade mit drei Eichpunkten],
)<figdrei>

In @figdrei erhalten wir einen Nullpunkt von $T_0 = qty(-271.1, "Celsius")$

#let co2 = $C O_2$
Im Trockeneis haben wir einen Druck von $p_co2 =qty("668+-1", "hPa")$ gemessen.
Damit können wir in @figdrei eine Temperatur von
$T_co2 = qty("-73.35", "Celsius")$ ablesen.

Wenn wir nun unseren Nullpunkt $T_0$ von den Temperaturwerten abziehen, erhalten
wir das Diagram mit einer Kelvin Skala: TODO ist das ok? ode rsoll man 273.15
abziehen?

#figure(
    image("drei_eichpunkte_kelvin.svg"),
    caption: [Eichgerade mit drei Eichpunkten mit einer Kelvin-Skala],
)


== Temperaturwerte des Gastherometers

Mit der Eichkurve in @figdrei können wir nun die Temperaturwerte, die wir mit
dem Gastherometer von #qty("0", "Celsius") bis #qty(0, "Celsius") gemessen
haben, bestimmen:

#figure(
    table(
        columns: 2,
        [Druck $p$ in hPa], [Temperatur $T$ in °C],
        num("914.0+-1.0"), num("-0.53+-0.30"),
        num("946.0+-1.0"), num("8.95+-0.30"),
        num("985.0+-1.0"), num("20.49+-0.30"),
        num("1016.0+-1.0"), num("29.67+-0.30"),
        num("1053.0+-1.0"), num("40.62+-0.30"),
        num("1086.0+-1.0"), num("50.39+-0.30"),
        num("1117.0+-1.0"), num("59.57+-0.30"),
        num("1147.0+-1.0"), num("68.45+-0.30"),
        num("1180.0+-1.0"), num("78.22+-0.30"),
        num("1213.0+-1.0"), num("87.99+-0.30"),
        num("1248.0+-1.0"), num("98.35+-0.30"),
    ),
    caption: [Temperatur des Wassers aus dem Druck des Gastherometers
        berechnet],
)<figT>

== PT-100 Element
In @figT haben wir die Temperatur für jeden Messpunkt im Wasser bestimmt.

Am PT100-Element haben wir die Spannung in der Vierleiterschaltung gemessen. Am
Widerstand liegt ein konstanter Strom $I_m = qty(1, "mA")$ an. Wir können also
den Widerstand in abhängigkeit von der Spannung berechnen:
$ R = U/I_m $

Damit können wir in @figR den Widerstand des PT-100 Elements als Funktion der
Temperatur auftragen: #figure(
    image("Widerstand_zu_Temp.svg"),
)<figR>

Die Steigung der Auslgeichsgerade beträgt:
$m = num("0.388+-0.008") #h(0.3em) Omega "°C"^(-1)$

TODO Referenz einleitung: Der lineare Teil der Temperaturabhängigkeit des PT-100
Widerstands beträgt:

$ R(T) = R_0 A T $
mit $A = num("3.9085e-3") #h(0.3em) "°C"^(-1)$.


Die Steigung $m$ der Ausgleichsgerade entspricht also dem Term $R_0 A$, mit
einer Sigma Abweichung von: $0.40 sigma$.

== Pyrometer

#figure(
    image("pyrometer.svg"),
    caption: [Mit dem Pyrometer gemessene Temperatur als Funktion der Temperatur
        des Gastherometers],
)<pyro>

In @pyro sieht man die Temperatur, die mit dem Pyrometer an der Wasseroberfläche
gemessen wurde als Funktion der tatsächlichen Temperatur (gemessen mit dem
Gasthermometer). Es fällt auf, dass die mit dem Pyrometer gemessene Temperatur
bis ca. #qty(50, "Celsius") innerhalb des Fehlerbereichs mit der tatsächlichen
Temperatur übeinstimmt. Bei höheren Temperaturen misst das Pyrometer allerdings
systematisch eine geringere Temperatur. Mögliche Ursachen werden in der
Diskussion aufgeführt.


= Diskussion

== Gastherometer
TODO

== PT-100 Element

Der PT-100 Widerstand hängt im Bereich von #qty(0, "Celsius") bis #qty(
    100,
    "Celsius",
) linear von der Temperatur ab. Das ist auch konsistent mit (Gleichung rererenz
zu der quadratischen Gleichung), da der Korrekturfaktor $B$ deutlich kleiner als
$A$ ist und daher im kleinen Temperaturbereich keinen großen Einfluss hat. Auch
die Steigung stimmt mit einer Abweichung von $0.4 sigma$ sehr gut mit dem
Parameter $A$ überein.

== Pyrometer

Bei einer Messung mit dem Pyrometer wird angenommen, dass die Messung an einem
schwarzen Strahler durchgeführt wird, also an einem Körper, der alle einfallende
Strahlung absorbiert und nur Wärmestrahlung aussendet.

Wasser reflektiert allerdings auch einen Teil der einfallenden Strahlung. Da
diese Strahlung aus der Umgebung (die auf Raumtemperatur liegt) kommt, wird die
Messung systematisch in Richtung der Raumtemperatur verfälscht.

Eine weitere Mögliche Fehlerquelle ist der Dampf, der bei höheren Temperaturen
auftritt. Da dieser nicht ganz transparent ist, wird zum teil auch die
Temperatur des Dampfs gemessen.











