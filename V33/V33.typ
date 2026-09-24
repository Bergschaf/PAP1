#import "@preview/unify:0.8.1": num, qty
#import "@preview/oxifmt:1.0.0": strfmt
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
    title: "Prismenspektrometer",
    versuch_nr: "33",
    authors: (
        (
            name: "Christian Krause",
            email: "christian.krause@stud.uni-heidelberg.de",
        ),
        (name: "Aaron Boheim", email: "aaron.boheim@stud.uni-heidelberg.de"),
    ),
    tutor: "Thora Charlotte Isermann",
    date: "21.09.2026",
)

#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")


#set page(numbering: "1")


// Format a (value, uncertainty) pair.
//
// Values are strings so that the original precision is preserved.
// For zero uncertainty, only the value is displayed.
#let format-uncertain(pair) = {
    let value = pair.at(0)
    let uncertainty = pair.at(1)

    let uncertainty-number = decimal(str(uncertainty))

    if uncertainty-number == 0 {
        num(str(value))
    } else {
        num(str(value) + "+-" + str(uncertainty))
    }
}

// Create a table containing:
//   Quantity | Measurement | Literature | SMD
//
// Each row has the form:
//   (label, (value, uncertainty), (literature-value, literature-uncertainty))
//
// Values should be strings, e.g. ("15.0", "0.5"), in order to preserve
// trailing zeros and therefore the input precision.
//
// SMD = (measurement - literature)
//       / sqrt(error_1^2 + error_2^2)
#let smd-table(
    rows,
    label-header: [Quantity],
    measurement-header: [Measurement],
    literature-header: [Literature],
    smd-header: [SMD],
    smd-digits: 2,
) = {
    let body = rows
        .map(row => {
            assert(
                row.len() == 3,
                message: "Each row must be (label, measurement, literature).",
            )

            let label = row.at(0)
            let measurement = row.at(1)
            let literature = row.at(2)

            assert(
                measurement.len() == 2,
                message: "Measurement must be (value, uncertainty).",
            )
            assert(
                literature.len() == 2,
                message: "Literature value must be (value, uncertainty).",
            )

            let value-1 = decimal(str(measurement.at(0)))
            let error-1 = decimal(str(measurement.at(1)))
            let value-2 = decimal(str(literature.at(0)))
            let error-2 = decimal(str(literature.at(1)))

            assert(
                error-1 >= 0,
                message: "Measurement uncertainty must be non-negative.",
            )
            assert(
                error-2 >= 0,
                message: "Literature uncertainty must be non-negative.",
            )

            let denominator = calc.sqrt(
                float(error-1 * error-1 + error-2 * error-2),
            )

            assert(
                denominator != 0,
                message: "The combined uncertainty must be non-zero.",
            )

            let smd = calc.abs(float(value-1 - value-2)) / denominator
            let smd-rounded = calc.round(smd, digits: smd-digits)

            (
                label,
                format-uncertain(measurement),
                format-uncertain(literature),
                num(strfmt("{0:.2}", smd-rounded)),
            )
        })
        .flatten()

    table(
        columns: 4,

        // Center the numerical columns.
        align: (left, center, center, center),

        table.header(
            label-header, measurement-header, literature-header, smd-header
        ),

        ..body,
    )
}
= Einleitung
== Ziel
Das Ziel von Versuch 33 ist es, die Wellenlängen der Linien des He-Spektrums zu
vermessen. Außerdem werden wir die $H_2$ Spektrallinien vermessen und damit die
Rydberg-Konstante berechnen.

== Physikalische Grundlagen

=== Minimalablenkwinkel

Am Anfang des Versuchs werden wir das Prisma auf den Minimalablenkwinkel
einstellen.
#figure(
    image("Prisma.png", width: 50%),
    caption: [Prisma],
)
Das bedeutet, dass das einfallende Licht senkrecht auf die Ebene trifft, die den
Winkel $epsilon$ halbiert. Dabei nimmt der Ablenkwinkel $delta$ ein Minimum ein
und es gilt:

$ alpha_"min" = alpha_1 = alpha_2 = (delta_min + epsilon)/2 $

und
$
    n = sin((delta_"min" + epsilon) / 2)/sin(epsilon/2) = sin(alpha_"min")/sin(epsilon/2)
$

Wir messen immer am minimalen Ablenkwinkel, da in diesem Fall $delta$ kaum vom
Einfallswinkel $alpha_1$ abhängt. Da der Brechungsindex $n$ von der Wellenlänge
$lambda$, wird ein parallel einfallendes, weißes Lichtbündel spektral zerlegt.

== Rydberg-Formel und Balmer-Serie

Die Energie, die ein Elektron auf einer bestimmten Schale mit der
Hauptquantenzahl $n$ im Bohr'schen Atommodell besitzt, ist gegeben durch
#let Ry = "Ry"
#let eV = "eV"
$ E_n = - Ry dot 1/n^2 $


mit der Rydberg-Energie $Ry approx 13.6 eV$.


Wenn ein angeregtes Elektron von einem höheren Energieniveau mit der


Hauptquantenzahl $m$ auf ein niedrigeres Energieniveau $n$ zurückfällt, wird die
Energiedifferenz als Photon abgegeben. Die Energie eines Photons ist durch

$ E_"ph" = h c / lambda $

gegeben. Dabei bezeichnet $h$ das Planck'sche Wirkungsquantum, $c$ die
Lichtgeschwindigkeit im Vakuum und $lambda$ die Wellenlänge des emittierten
Lichts.

Die Energie des emittierten Photons entspricht der Differenz der beiden
Energieniveaus. Damit folgt

$
    E_"ph" = E_m - E_n
    = Ry (1/n^2 - 1/m^2)
$

und somit

$ h c / lambda = Ry (1/n^2 - 1/m^2) $.

Teilt man durch den konstanten Faktor $h c$, erhält man aus der Rydberg-Energie
die Rydberg-Konstante

$ R_infinity = Ry/(h c) approx 1.0973731568157 dot 10^7 m^(-1) $.

Damit ergibt sich die Rydberg-Formel

$ 1/lambda = R_infinity (1/n^2 - 1/m^2) $.

Dabei ist $m$ die Hauptquantenzahl des angeregten Zustands und $n$ die
Hauptquantenzahl des Zustands, auf den das Elektron zurückfällt. Es gilt
$m > n$. Für den Versuch ist insbesondere die Balmer-Serie relevant. Sie
entsteht für Übergänge auf die Schale mit $n=2$. Setzt man dies in die
Rydberg-Formel ein, erhält man die Balmer-Formel

$ 1/lambda = R_infinity (1/2^2 - 1/m^2) $

#let nm = "nm"
mit $m = 3, 4, 5, ...$. Die zugehörigen Spektrallinien liegen im sichtbaren
Bereich. Die ersten vier Linien der Balmer-Serie werden mit $H_alpha$, $H_beta$,
$H_gamma$ und $H_delta$ bezeichnet und besitzen die Wellenlängen $656.3 "nm"$,
$486.1 nm$, $434.0 nm$ und $410.1 nm$.

= Protokoll

#figure(
    grid(
        columns: 2,
        image("Protokoll.pdf", width: 65%, page: 1),
        image("Protokoll.pdf", width: 65%, page: 2),
    ),
)
= Auswertung

== Wellenlängenbestimmung des He-Spektrums

#let deg(x, y) = $#x°#y'$
#figure(
    image("Zeichnung.pdf", page: 2, width: 80%),
    caption: [Winkeldispersionskurve $delta(lambda)$],
)<fig1>

In @fig1 sieht man die Auslenkung des Teleskops als Funktion der Wellenlänge für
10 der Hg-Spektrallinien.

Die Kurve habe ich wir von Hand abgeschätzt. Da die Fehler so klein sind und im
Prinzip alle Messwerte auf der Kurve liegen, habe ich keine weitere Fehlerkurven
eingezeichnet.

Für den Fehler der Auslenkungsmessung $Delta delta$ mit dem Nonius haben wir ein
Skalenteil, also eine Bogenminute verwendet $Delta delta = deg(0, 1)$.

Anschließend haben wir mit @fig2 die Wellenlängen zu den gemessenen Auslenkungen
der He-Spektrallinien bestimmt:

#figure(
    image("Zeichnung.pdf", page: 3, width: 80%),
    caption: [Bestimmung der Wellenlängen der He-Spektrallinien],
)<fig2>



#let data = (
    ("1", (666, 4), (667.8, 0)),
    ("2", ("570.0", "2.0"), (587.6, 0)),
    ("3", ("504.0", 1.5), ("501.6", 0)),
    ("4", (491.5, 1.5), ("492.2", 0)),
    ("5", ("471.0", "1.0"), ("471.3", 0)),
)

#figure(
    smd-table(
        data,
        label-header: [Nr],
        measurement-header: [Gemessene Wellenlänge $lambda$ in nm],
        literature-header: [Literaturwert für $lambda$ in nm],
        smd-header: [Abweichung $z$],
        smd-digits: 2,
    ),
    caption: [Werte für die Wellenlängen der He-Spektrallinien],
)

== Bestimmung der Wellenlängen der $H_2$ Spektrallinien

#figure(
    image("Zeichnung.pdf", page: 4, width: 80%),
    caption: [Bestimmung der Wellenlängen der $H_2$ Spektrallinien],
)<fig3>


#let data = (
    ("1", (637, 3), (656.3, 0)),
    ("2", ("481.0", "1.5"), (486.1, 0)),
    ("3", ("428.0", "1.0"), ("434.0", 0)),
)


#figure(
    smd-table(
        data,
        label-header: [Nr],
        measurement-header: [Gemessene Wellenlänge $lambda$ in nm],
        literature-header: [Literaturwert für $lambda$ in nm],
        smd-header: [Abweichung $z$],
        smd-digits: 2,
    ),
    caption: [Werte für die Wellenlängen der $H_2$-Spektrallinien],
)
Die Fehler haben wir wieder wie bei bei der Wellenlängenbestimmung des
He-Spektrums abgeschätzt.

=== Rydberg-Konstante

Anschließend haben wir die Balmer-Formel aus dem Skript verwendet, um die
Rydberg-Konstante zu berechnen:

$ 1/lambda = R_infinity (1/2^2 - 1/m^2) $

#figure(
    table(
        columns: 3,
        [Farbe],
        [Berechneter Wert für $R_infinity$ in $m^(-1)$],
        [Abweichung $z$ zum Literaturwert],

        [Rot], num("1.130+-0.005e7"), num("6.19"),
        [Türkis], num("1.1088+-0.0035e7"), num("3.31"),
        [Violett], num("1.1126+-0.0026e7"), num("5.86"),
    ),
    caption: [Verschiedene Werte für die Rydberg Konstante],
)


Um die Werte in den Kontext zu setzten, zeigen wir in der letzten Spalte die
Abweichung $z$ zum Literaturwert $R_infinity = qty("1.0973731568157", "m^-1")$.


Abweichung $z$ zum Literaturwert
$R_infinity = qty("1.0973731568157", "m^-1")$.Die Abweichung $z$ zweier
fehlerbehafteter Werte $a_1$ und $a_2$ ist definiert als:
$ z = abs(a_1 - a_2)/sqrt((Delta a_1)^2 + (Delta a_2)^2) $

Die Fehler haben wir wie gewohnt mit Gaußscher Fehlerfortpflanzung berechnet.
Dafür haben wir das Python-Package `uncertainties` verwendet.
= Ergebnisse

#let data = (
    ("1", (666, 4), (667.8, 0)),
    ("2", ("570.0", "2.0"), (587.6, 0)),
    ("3", ("504.0", 1.5), ("501.6", 0)),
    ("4", (491.5, 1.5), ("492.2", 0)),
    ("5", ("471.0", "1.0"), ("471.3", 0)),
    ("6", (446.5, "1.0"), ("447.1", 0)),
)
#figure(
    smd-table(
        data,
        label-header: [Nr],
        measurement-header: [Gemessene Wellenlänge $lambda$ in nm],
        literature-header: [Literaturwert für $lambda$ in nm],
        smd-header: [Abweichung $z$],
        smd-digits: 2,
    ),
    caption: [Werte für die Wellenlängen der He-Spektrallinien],
)

#let data = (
    ("1", (637, 3), (656.3, 0)),
    ("2", ("481.0", "1.5"), (486.1, 0)),
    ("3", ("428.0", "1.0"), ("434.0", 0)),
)
#figure(
    smd-table(
        data,
        label-header: [Nr],
        measurement-header: [Gemessene Wellenlänge $lambda$ in nm],
        literature-header: [Literaturwert für $lambda$ in nm],
    ),
    caption: [Wellenlängen der $H_2$ Spektrallinien],
)<tabh2>
#figure(
    table(
        columns: 3,
        [Farbe],
        [Berechneter Wert für $R_infinity$ in $m^(-1)$],
        [Abweichung $z$ zum Literaturwert],

        [Rot], num("1.130+-0.005e7"), num("6.19"),
        [Türkis], num("1.1088+-0.0035e7"), num("3.31"),
        [Violett], num("1.1126+-0.0026e7"), num("5.86"),
    ),
    caption: [Verschiedene Werte für die Rydberg Konstante],
)<tabry>


= Diskussion

== Wellenlängenbestimmung des He-Spektrums

Man sieht, dass die Werte innerhalb ihrer Fehlerbereiche mit den Literaturwerten
übereinstimmen. Bei die zweite Linie weicht allerdings stark vom Literaturwert
ab. Fine Mögliche Ursache wäre die Verwechselung mit einer anderen, schwächeren
Linie oder die falsche Einstellung des Fernrohrs.

== Wellenlängenbestimmung des $H_2$ Spektrums und berechnung der Rydberg-Konstante
Man sieht in @tabh2 und @tabry, dass die Wellenlängen des $H_2$ Spektrums und
die Werte für die Rydberg-Konstante deutlich von den Literaturwerten abweichen.
Da wir die Kalibrierung des Aufbaus seit dem ersten Versuchsteil nicht verändert
hatten, ist ein systematische Fehler unwahrscheinlich. Möglich wäre allerdings
eine Änderung äußerer parameter (z.B. Temperatur oder Ausleuctung des Raumes).
Die hohen Abweichungen lassen sich aber dadurch erklären, dass wir den Fehler
beim Ablesen aus der Winkeldispersionskurve nur mit der oben erklärten Methode
geschätzt, nicht aber korrekt (am Computer) ausgerechnet haben. Dadurch haben
wir den Fehler vermutlich deutlich unterschätzt.
