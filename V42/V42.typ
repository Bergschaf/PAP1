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
Für die Einleitung und die Durchführung wurde KI als Formulierungshilfe
verwendet.

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
$<gl_spez_wärme>

Der Wasserwert wird zunächst separat bestimmt. Für die Bestimmung wird heißes
Wasser mit der Temperatur $T_1$ in das Kalorimeter mit Wasser der Temperatur
$T_2$ gegeben. Aus der Wärmebilanz folgt

$
    W =
    m_W c_W (T_1-T)/(T-T_2) .
$<wasserwert>

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
    (Q_V m_V)/(m_x (T_1-T_2)) .
$<c_x_stickstoff>

Da auch ohne Probekörper Stickstoff durch die Umgebung verdampft, muss diese
Verdampfungsrate bei der Bestimmung von $m_V$ berücksichtigt werden.


= Durchführung

== Vorbereitung

Zunächst werden die Massen der drei großen und drei kleinen Probekörper mit der
elektronischen Waage bestimmt. Für die Messungen wird das Kalorimeter mit
VE-Wasser verwendet. Vor Beginn der Messungen wird der Magnetrührer überprüft
und so eingestellt, dass das Wasser im Kalorimeter gleichmäßig durchmischt wird.

Bei den Messungen mit den großen Probekörpern wird darauf geachtet, dass der
Probekörper das Thermometer nicht berührt. Das Thermometer wird deshalb seitlich
vom Probekörper im Wasser positioniert.

== Bestimmung des Wasserwerts

Zunächst wird die Masse des leeren Kalorimeters ohne Deckel, jedoch mit Netz und
Rührfisch, bestimmt. Das Kalorimeter muss hierfür vollständig trocken sein.
Anschließend wird die Raumtemperatur als Anfangstemperatur $T_2$ des
Kalorimeters gemessen.

Wasser wird auf etwa $50 "°C"$ erhitzt. Nach Abschalten der Heizplatte wird das
Wasser unter ständigem Rühren so lange stehen gelassen, bis sich eine konstante
Temperatur eingestellt hat. Diese Temperatur wird als $T_1$ notiert.

Anschließend wird die Zeitmessung gestartet und das heiße Wasser möglichst
schnell in das Kalorimeter eingefüllt. Das Kalorimeter wird sofort verschlossen
und der Magnetrührer eingeschaltet. Die Temperatur wird über fünf Minuten in
Abständen von $30 "s"$ aufgenommen. Aus dem linearen Temperaturabfall nach dem
Einfüllen wird durch Extrapolation auf den Zeitpunkt des Einfüllens die
Mischungstemperatur $overline(T)$ bestimmt.

Nach der Messung wird das vollständig gefüllte Kalorimeter erneut gewogen. Aus
der Massendifferenz wird die Masse des Wassers bestimmt:

$ m_W = m_"voll" - m_"leer" . $


== Bestimmung der Wärmekapazitäten mit heißem Wasser

Das Kalorimeter wird für jede Messung etwa zu drei Vierteln mit frischem
VE-Wasser gefüllt und gewogen. Aus der Massendifferenz zum leeren Kalorimeter
wird die Wassermasse bestimmt. Vor jeder Messung wird außerdem die
Anfangstemperatur $T_2$ des Wassers im Kalorimeter bestimmt.

Die Probekörper werden in einem mit Wasser gefüllten Glasbecher in siedendem
Wasser mindestens fünf Minuten erhitzt. Dabei dürfen sie den Boden des
Glasbechers nicht berühren. Die Temperatur des siedenden Wasserbads wird als
$T_1$ bestimmt.

Anschließend wird der Probekörper schnell aus dem Wasserbad genommen und in das
Kalorimeter eingesetzt. Das Kalorimeter wird sofort verschlossen und die
Temperatur unter ständigem Rühren beobachtet. Die maximale Temperatur wird als
Mischungstemperatur $T$ verwendet.


== Bestimmung der Wärmekapazitäten mit flüssigem Stickstoff

Für diesen Versuchsteil werden die kleinen Probekörper verwendet. Der Dewar wird
etwa zu drei Vierteln mit flüssigem Stickstoff gefüllt und auf die Waage
gestellt. Nach dem Temperaturausgleich wird die Masse zweimal im Abstand von
zwei Minuten gemessen. Daraus wird die natürliche Verdampfungsrate des
Stickstoffs bestimmt.

Anschließend wird die Anfangsmasse des Dewars unmittelbar vor dem Einbringen des
Probekörpers bestimmt. Der Probekörper wird langsam an einem Faden in den
flüssigen Stickstoff eingetaucht und gleichzeitig die Zeitmessung gestartet. Die
Zeit bis zum Ende des Siedevorgangs wird notiert.

Nach vollständigem Abkühlen des Probekörpers wird dieser wieder herausgenommen
und die Endmasse des Dewars bestimmt. Aus Anfangs- und Endmasse wird zunächst
die gesamte verdampfte Stickstoffmasse bestimmt. Die Verdampfung durch die
Umgebung wird anschließend anhand der zuvor bestimmten Verdampfungsrate
korrigiert.


= Versuchsprotokoll

#show figure: set block(breakable: true)

#figure(
    grid(
        columns: 2,
        image("Versuchsprotokoll.pdf", page: 1, width: 90%),
        image("Versuchsprotokoll.pdf", page: 2, width: 90%),

        image("Versuchsprotokoll.pdf", page: 3, width: 90%),
        image("Versuchsprotokoll.pdf", page: 4, width: 90%),

        image("Versuchsprotokoll.pdf", page: 5, width: 90%),
    ),
    caption: [Versuchsprotokoll],
)

= Auswertung


== Bestimmung des Wasserwerts

#figure(
    caption: [Graphische Bestimmung von $overline(T)$],
    image("Zeichnung.pdf", page: 1, width: 80%),
)<T_bar>
TODO rumargumentieren warum man die riesigen fehlerbalken ignoriert

$ overline(T) = qty("53.06+-1.2", "Celsius") $

Wir können nun mit @wasserwert den Wasserwert $W$ berechnen:

$ W = qty("80+-40", "J/K") $


=== Fehlerrechnung
Aus den Wägungen ergibt sich zunächst die Wassermasse

$ m_W = m_"voll" - m_"leer" . $

Die Unsicherheit ergibt sich mit der Gaußschen Fehlerfortpflanzung zu

$
    Delta m_W =
    sqrt(
        (Delta m_"voll")^2 +
        (Delta m_"leer")^2
    ) .
$

Der Wasserwert des Kalorimeters wird mit

$
    W =
    m_W c_W
    (T_1-overline(T))/(overline(T)-T_2)
$

bestimmt.

Für die Fehlerrechnung wird das totale Fehlerdifferential verwendet. Die
partiellen Ableitungen lauten

$
    (partial W)/(partial m_W)
    = c_W (T_1-overline(T))/(overline(T)-T_2) ,
$

$
    (partial W)/(partial c_W)
    = m_W (T_1-overline(T))/(overline(T)-T_2) ,
$

$
    (partial W)/(partial T_1)
    = (m_W c_W)/(overline(T)-T_2) ,
$

$
    (partial W)/(partial T_2)
    = m_W c_W (T_1-overline(T))/(overline(T)-T_2)^2 ,
$

und

$
    (partial W)/(partial overline(T))
    = -m_W c_W
    (
        1/(overline(T)-T_2)
        +
        (T_1-overline(T))/(overline(T)-T_2)^2
    ) .
$

Damit ergibt sich

$
    Delta W =
    sqrt(
        ((partial W)/(partial m_W) Delta m_W)^2
        +
        ((partial W)/(partial c_W) Delta c_W)^2
        +
        ((partial W)/(partial T_1) Delta T_1)^2
        + \
        ((partial W)/(partial T_2) Delta T_2)^2
        +
        ((partial W)/(partial overline(T)) Delta overline(T))^2
    ) .
$

== Bestimmung der Wärmekapazitäten im Wasser
Jetzt können wir @gl_spez_wärme verwenden, um die Spezifische Wärmekapazität
$C_x$ zu berechnen. Die Molare Wärmekapazität $c_"x mol"$ ergibt sich aus dem
Produkt der spezifischen Wärmekapazität und der molaren Masse $M_"mol"$:
$ c_"x mol" = c_x dot M_"mol" $

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
Zur übersichtlicheren Fehlerrechnung wird

$ A = m_W c_W + W $

definiert. Damit lautet die Gleichung

$ c_x = A/m_x (T-T_2)/(T_1-T) . $

Die benötigten partiellen Ableitungen sind

$
    (partial c_x)/(partial m_W)
    = c_W/m_x (T-T_2)/(T_1-T) ,
$

$
    (partial c_x)/(partial c_W)
    = m_W/m_x (T-T_2)/(T_1-T) ,
$

$
    (partial c_x)/(partial W)
    = 1/m_x (T-T_2)/(T_1-T) ,
$

$
    (partial c_x)/(partial m_x)
    = -A/m_x^2 (T-T_2)/(T_1-T) ,
$

$
    (partial c_x)/(partial T)
    = A/m_x
    (T_1-T_2)/(T_1-T)^2 ,
$

$
    (partial c_x)/(partial T_1)
    = -A/m_x (T-T_2)/(T_1-T)^2 ,
$

und

$
    (partial c_x)/(partial T_2)
    = -A/(m_x(T_1-T)) .
$

Damit folgt für die Unsicherheit

$
    Delta c_x =
    sqrt(
        ((partial c_x)/(partial m_W) Delta m_W)^2
        +
        ((partial c_x)/(partial c_W) Delta c_W)^2
        +
        ((partial c_x)/(partial W) Delta W)^2
        +
        ((partial c_x)/(partial m_x) Delta m_x)^2
        + \
        ((partial c_x)/(partial T) Delta T)^2
        +
        ((partial c_x)/(partial T_1) Delta T_1)^2
        +
        ((partial c_x)/(partial T_2) Delta T_2)^2
    ) .
$
$ dif c_x = "TODO" $

Zur Berechnung der molaren Wärmekapazität wird der Literaturwert für die Molare
Masse $M_"mol"$ verwendet:
$ c_"x mol" = M_"mol" dot c_x $
Der Fehler von $M_"mol"$ ist vernachlässigbar gegenüber dem Fehler von $c_x$,
d.h. der Fehler $Delta c_"x mol"$ kann einfach berechnet werden:
$Delta c_"x mol" = Delta x_x dot M_"mol"$.

== Bestimmnung der Wärmekapazitäten im Flüssigen Stickstoff

Als erstes habe ich die Zeitdifferenzen zwischen eintauchen und herausholen der
Körper aus dem flüssigen Stickstoff bestimmt. Den Fehler der Zeiten schätzen wir
als $Delta t = qty(5, "s")$, da der Prozess das absenken und herausheben der
Masse immer eine gewisse Zeit benötigt hat und da wir das Gewicht und die Zeit
nicht immer exakt gleichzeitig abgelesen haben. Bei der Differenzbildung ist zu
beachten, dass der Fehler sich quadratisch addiert.

Auch bei der Massendifferenz wird der Fehler wieder quadratisch addiert.

TODO TODO


Wir haben nun alle Werte berechnet, die wir benötigen um die Wärmekapazität der
Probekörper $c_x$ mit @c_x_stickstoff zu berechnen.

Hier ist zu beachten, dass wir nicht die Wärmekapazität $c_x$ beim Siedepunkt
von Stickstoff, also $T_2 = qty(-195.8, "Celsius")$ bestimmen, sondern die
Wärmekapazität gemittelt über den Bereich von der Raumtemperatur
$T_1 = qty("24.9+-1", "Celsius")$ bis $T_2$, da der Körper sich im Laufe des
Experiments von $T_1$ bis $T_2$ abkühlt. Das ist relevant, da $c_x$
temperaturabhängig ist.

#figure(
    table(
        columns: 3,
        [Material],
        [Gemessene Spezifische Wärmekapazität $c_x$ in
            $"J" "K"^(-1)"Kg"^(-1)$],
        [Gemessene Molare Wärmekapazität in $"J" "K"^(-1) "mol"^(-1)$],

        [Blei], num("120.9+-0.8"), num("25.05+-0.17"),
        [Alu], num("729+-4"), num("19.67+-0.11"),
        [Graphit], num("401.7+-2.7"), num("4.824+-0.032"),
    ),
    caption: [Wärmekapazität bestimmt in flüssigem Stickstoff],
)

== Bestimmnug der Debye-Temperatur

Um die Debye-Temperatur zu bestimmen berechnen wir zunächst das Verhältniss
$R_c$ aus der Wärmekapazität beim Siedepunkt von Wasser $c_(x H_2 O)$ und beim
Siedepunkt von Stickstoff $x_(x N_2)$:

$ R_c = c_(x N_2) / c_(x H_2 O) $

Unter verwendung von diesem Verhältnis, kann aus Abbildung 3 im Skript die Debye
Temperatur abgeschätzt werden. Da das Diagramm keine Millimeterlinien besitzt,
ist die Abschätzung allerdings sehr grob,


#figure(
    table(
        columns: 3,
        [Material], [Verhältnis $R_c$], [Debye Temperatur in $K$],
        [Blei], num("1.1+-0.5"), num("100"),
        [Alu], num("0.87+-0.23"), num("300+-300"),
        [Graphit], num("0.51+-0.18"), num("950+-1000"),
    ),
    caption: [Verhältnis der Wärmekapazitäten und Debye Temperatur],
)
Durch die großen Fehler von $c_(x H_2 O)$ ist es hier nicht sehr aussagekräftig,
die Debye Temperatur abzulesen. Darum habe ich Verhältnisse nocheinmal neu
berechnet, dieses mal aus dem Literaturwert für $c_(x H_2 O)$ und dem gemessenen
Wert für $c_(x N_2)$.
#figure(
    table(
        columns: 4,
        [Material],
        [Verhältnis $c_(x N_2) / c_(x H_2 O)$],
        [Debye Temperatur in $K$],
        [Literaturwert für die Debye Temperatur in $K$],

        [Blei], num("0.937+-0.006"), num("180+-20"), num("95"),
        [Alu], num("0.810+-0.005"), num("390+-20"), $430$,
        [Graphit], num("0.566+-0.004"), num("700+-20"), $2230$,
    ),
    caption: [Verhältnis der Wärmekapazitäten und Debye Temperatur],
)

=== Fehlerrechnung
Um die Wärmekapazität bei Raumtemperatur und bei der Temperatur des flüssigen
Stickstoffs miteinander zu vergleichen, wird für jeden Probekörper das
Verhältnis

$
    R_c =
    c_(x N_2)/c_(x H_2 O)
$

gebildet.

Für die Fehlerfortpflanzung gilt

TODO

= Ergebnisse

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
)<res_warm>
TODO

= Diskussion

== Wasserwert
Man sieht in @T_bar, dass der Fehler des Thermometers sehr groß ist im Vergleich
zu der Abnahme der Wassertemperatur über die Zeit. Ich habe mich dazu
entschieden, die Fehlerabschätzung in diesem Diagramm nicht über den (zu großen)
systematischen Fehler des Therometers, sondern über den statistischen Fehler der
Messungen zu machen. Vermutlich gibt der Hersteller einen großen Systematischen
Fehler an, um die Genauigkeit des Geräts sicher zu überschätzen.

Der gemessene Wasserwert stimmt innerhalb des Fehlerbereichs mit der
Herstellerangabe im Skript überein. Der sehr große relativen Fehler von $50%$
wird durch die sehr hohe Fehlerangabe des Thermometers verursacht.

== Wärmekapazitäten in Wasser

In @res_warm sieh man, dass die berechneten Spezifischen Wärmekapazitäten alle
innerhalb des Fehlerbereichs der Literaturwerte liegen. Auch hier fällt auf,
dass die Fehler sehr groß sind, was hauptsächlich an dem vorher berechneten
Wasserwert mit dem sehr großen Fehler liegt.

Für Aluminium und Blei liegt die molare Wärmekapazität auch sehr nah an der
Dulong-Petit'schen Regel. Die molare Wärmekapazität von Graphit weicht
allerdings sehr siginifikant von der vorhersage der Dulong-Petit'schen Regel ab.
Das liegt vermutlich daran, dass Graphit eine komplexe Schichtstruktur besitzt,
die nicht einfach durch drei Freiheitsgrade erklärt werden kann.

== Wärmekapazitäten in flüssigem Stickstoff



