#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")
#import "@preview/oxifmt:1.0.0": strfmt

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
    title: "Wärmekapazität",
    versuch_nr: "42",
    authors: (
        (
            name: "Christian Krause",
            email: "christian.krause\@stud.uni-heidelberg.de",
        ),
        (
            name: "Alois Bachmann",
            email: "alois.bachmann\@stud.uni-heidelberg.de",
        ),
    ),
    tutor: "Michael Gotzmann",
    date: "1.10.2026",
)

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

== Ziel des Versuchs

Ziel des Versuchs ist die Bestimmung der spezifischen und molaren Wärmekapazität
der Festkörper Aluminium, Graphit und Blei. Dazu werden die Wärmekapazitäten
zunächst im Temperaturbereich von etwa $20$ bis $100 °C$ mit einem
Mischungskalorimeter bestimmt. Anschließend werden die Wärmekapazitäten bei der
Temperatur von flüssigem Stickstoff untersucht. Die Ergebnisse werden mit den
Literaturwerten und der Dulong-Petit-Regel verglichen. Aus der
Temperaturabhängigkeit soll außerdem qualitativ die Debye-Temperatur der
untersuchten Materialien abgeschätzt werden.

== Physikalische Grundlagen

Wird einem Körper die Wärmemenge $Q$ zugeführt, so erhöht sich, sofern kein
Phasenübergang stattfindet, seine Temperatur um $Delta T$. Die Wärmekapazität
$C$ ist definiert als

$ C = Q/(Delta T) . $

Sie gibt an, welche Wärmemenge benötigt wird, um die Temperatur eines Körpers um
$1 "K"$ zu erhöhen. Da $C$ von der Masse des Körpers abhängt, wird die
spezifische Wärmekapazität

$ c = Q/(m Delta T) $

eingeführt. Mit der molaren Masse $M$ ergibt sich die molare Wärmekapazität zu

$ c_"mol" = M c = M/m Q/(Delta T) . $

Die Wärmekapazität eines Festkörpers ist mit den mikroskopischen Freiheitsgraden
seiner Atome verknüpft.

== Klassische Festkörperphysik

In einem Festkörper können die Atome in guter Näherung als harmonische
Oszillatoren betrachtet werden. Jedes Atom besitzt dabei drei
Schwingungsfreiheitsgrade. Für ein Mol eines einatomigen Festkörpers existieren
somit $3 N_A$ Schwingungsfreiheitsgrade.

Nach dem Äquipartitionsprinzip trägt jeder quadratische Freiheitsgrad im Mittel
die Energie $1/2 k T$ bei. Da bei einer harmonischen Schwingung jeweils ein
kinetischer und ein potentieller Anteil auftreten, beträgt die mittlere Energie
pro Schwingungsfreiheitsgrad $k T$. Für ein Mol folgt damit

$ U_"mol" = 3 N_A k T = 3 R T . $

Durch Ableiten der inneren Energie nach der Temperatur erhält man die molare
Wärmekapazität

$ c_"mol" = dif U_"mol"/dif T = 3 R . $

Damit ergibt sich die Dulong-Petit-Regel

$ c_"mol,DP" = 3 R = 24.942 "J K"^(-1) "mol"^(-1) . $

Die klassische Beschreibung sagt somit eine temperaturunabhängige molare
Wärmekapazität voraus. Experimentell zeigt sich jedoch insbesondere bei tiefen
Temperaturen eine deutliche Abweichung von diesem Verhalten.

== Quantenverbesserung nach Einstein

Die Abweichung von der klassischen Theorie lässt sich dadurch erklären, dass die
Schwingungsenergien in einem Festkörper quantisiert sind. Für einen Oszillator
mit der Frequenz $nu$ sind die Energiezustände diskret. Die Wahrscheinlichkeit
für die Anregung eines Zustandes hängt von der Temperatur ab.

Einstein modellierte einen Festkörper als System unabhängiger Oszillatoren mit
einer gemeinsamen Eigenfrequenz. Bei hohen Temperaturen können die
Schwingungsfreiheitsgrade nahezu vollständig angeregt werden, sodass sich wieder
das Dulong-Petit-Limit ergibt. Bei tiefen Temperaturen werden dagegen immer
weniger Schwingungszustände angeregt und die Wärmekapazität nimmt ab. Damit
erklärt das Einstein-Modell qualitativ die beobachtete Temperaturabhängigkeit
der Wärmekapazität.

== Debye-Modell

Im Debye-Modell werden die Schwingungen der Atome nicht als unabhängig
betrachtet. Die Atome eines Festkörpers sind gekoppelt, sodass kollektive
Schwingungsmoden entstehen. Diese Anregungen werden als Phononen bezeichnet.

Anstelle einer einzigen Eigenfrequenz wird ein kontinuierliches Spektrum von
Schwingungsfrequenzen angenommen. Die maximale Frequenz wird durch die
Debye-Frequenz $omega_D$ beschrieben. Die zugehörige Debye-Temperatur ist

$ Theta_D = (ℏ omega_D)/k . $

Die molare Wärmekapazität ergibt sich im Debye-Modell zu

$
    c_"mol,Debye" =
    9 R (T/Theta_D)^3
    integral_0^(Theta_D/T)
    (x^4 exp(x))/(exp(x)-1)^2 dif x .
$

Dabei ist

$ x = (ℏ omega)/(k T) . $

Für hohe Temperaturen nähert sich die Wärmekapazität dem Dulong-Petit-Limit
$3R$. Für tiefe Temperaturen geht sie dagegen proportional zu $T^3$ gegen null.
Die Debye-Temperatur charakterisiert dabei die energetische Skala der
Gitterschwingungen eines Materials.

Da die Messung jeweils über einen Temperaturbereich erfolgt, wird die gemessene
Wärmekapazität näherungsweise als Mittelwert über diesen Bereich aufgefasst:

$
    overline(c)*"mol" =
    1/(T_2-T_1)
    integral*(T_1)^(T_2) c_"mol,Debye"(T) dif T .
$

== Messprinzip des Mischungskalorimeters

Bei der Mischungsmethode wird ein erhitzter Probekörper mit der Temperatur $T_1$
in ein Kalorimeter mit Wasser der Temperatur $T_2$ eingebracht. Nach kurzer Zeit
stellt sich die Mischungstemperatur $T$ ein. Unter Vernachlässigung von
Wärmeverlusten an die Umgebung gilt Energieerhaltung.

Die vom Probekörper abgegebene Wärme ist

$ Q_x = m_x c_x (T_1-T) . $

Wasser und Kalorimeter nehmen dagegen die Wärme

$ Q_"auf" = (m_W c_W + W)(T-T_2) $

auf. Dabei bezeichnet $W$ den Wasserwert des Kalorimeters, also dessen effektive
Wärmekapazität. Aus $Q_x = Q_"auf"$ folgt

$
    c_x =
    ((m_W c_W + W)(T-T_2))/(m_x(T_1-T)) .
$

Der Wasserwert wird zunächst separat bestimmt. Für die Bestimmung wird heißes
Wasser mit der Temperatur $T_1$ in das Kalorimeter mit Wasser der Temperatur
$T_2$ gegeben. Aus der Wärmebilanz folgt

$
    W =
    m_W c_W (T_1-T)/(T-T_2) .
$

Da der Temperaturausgleich sehr schnell erfolgt, wird die Mischungstemperatur
durch Extrapolation des nachfolgenden linearen Temperaturabfalls auf den
Zeitpunkt des Mischens bestimmt.

== Messung bei flüssigem Stickstoff

Im zweiten Versuchsteil wird der Probekörper von Raumtemperatur auf die
Temperatur des flüssigen Stickstoffs abgekühlt. Die Temperatur des flüssigen
Stickstoffs beträgt

$ T_2 = -195.8 "°C" . $

Die beim Abkühlen des Probekörpers abgegebene Wärme wird über die
Verdampfungswärme des Stickstoffs bestimmt. Es gilt

$ Q = Q_V m_V = m_x c_x (T_1-T_2) , $

wobei $Q_V$ die spezifische Verdampfungswärme und $m_V$ die verdampfte Masse des
Stickstoffs bezeichnet. Damit folgt

$
    c_x =
    (Q_V m_V)/(m_x(T_1-T_2)) .
$

Da auch ohne Probekörper Stickstoff durch die Umgebung verdampft, muss diese
Verdampfungsrate bei der Bestimmung von $m_V$ berücksichtigt werden.


= Durchführung

TODO

= Versuchsprotokoll

TODO

= Auswertung


== Bestimmung des Wasserwerts

#figure(
    caption: [Graphische Bestimmung von $overline(T)$],
    image("Zeichnung.pdf", page: 1),
)
TODO rumargumentieren warum man die riesigen fehlerbalken ignoriert

$ overline(T) = qty("53.06+-1.2", "Celsius") $

Wir können nun mit @wasserwert den Wasserwert $W$ berechnen:

$ W = qty("80+-40", "J/K") $


=== Fehlerrechnung

$
    dif W = m_w c_w ((1)/(overline(T) - T_2) dif T_1 + (T_1 - overline(T))/(overline(T) - T_2)^2 dif T_2 + (-1/(overline(T) - T_2) - (T_1 - overline(T))/(overline(T) - T_2)^2) dif overline(T)) \ + W/c_W dif c_W + W/m_w dif m_w
$

Da wir $m_w$ aus der Differenz der Masse des leeren und des vollen Kalrorimeters
bestimmen, müssen wir das auch in der Fehlerrechnung mit einbeziehen, d.h.
$Delta m_W = sqrt((Delta m_"voll")^2 + (Delta m_"leer")^2)$.

== Bestimmung der Wärmekapazitäten
Jetzt können wir @gl_spez_wärme verwenden, um die Spezifische Wärmekapazität zu
berechnen:

TODO Einleitung

$c_"mol DP" = 3 R = qty("24.942", "J/K/mol")$

#figure(
    pad(x: -5em, table(

        columns: 7,
        [Material],
        [Gemessene Spezifische Wärmekapazität $c_x$ in
            $"J" "K"^(-1)"Kg"^(-1)$],
        [Litearturwert für $c_x$ in $"J" "K"^(-1)"Kg"^(-1)$],
        [Abweichung $z$ zum Literaturwert],
        [Gemessene Molare Wärmekapazität in $"J" "K"^(-1) "mol"^(-1)$],
        [Literaturwert für molare Wärmekapazität $c_x dot M_"mol"$],
        [Abweichung $z$ zu $c_"mol DP"$],

        [Alu], num("8.4+-2.2e2"), $900$, $0.29$, num("23+-6"), $24.282$, $0.4$,
        [Graphit],
        num("7.9+-2.7e2"),
        $709$,
        $0.29$,
        num("9.5+-3.3"),
        $8.51509$,
        $4.69$,

        [Blei],
        num("1.1+-0.6e2"),
        $129$,
        $0.26$,
        num("24+-12"),
        $26.7288$,
        $0.11$,
    )),

    caption: [Spezifische Wärmekapazitäten im Vergleich mit den Literaturwerten,
        #footnote[Die Literaturwerte sind aus dem PAP-Skript]
    ],
)

Um die Abweichungen zu den Litearturwerten in Kontext zu setzen, haben wir die
Sigma-Abweichung $z$ berechnet:

$
    z = abs(a_1 - a_2)/sqrt((Delta a_1)^2 + (Delta a_2)^2) quad "für zwei fehlerbehaftete Variablen" a_1 "und" a_2
$


=== Fehlerrechnung

$ dif c_x = "TODO" $


==


= Diskussion

== Wasserwert

Gschissn oida

== Wärmekapazitäten


