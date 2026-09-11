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
    title: "Mathematisches TODO Pendel",
    versuch_nr: "13",
    authors: (
        (
            name: "Christian Krause",
            email: "christian.krause@stud.uni-heidelberg.de",
        ),
        (name: "Aaron Boheim", email: "aaron.boheim@stud.uni-heidelberg.de"),
    ),
    tutor: "Pham Huy Thang Le ",
    date: "3.09.2026",
)

#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")


#set page(numbering: "1")
#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange

= Einleitung
TODo

= Protkoll

#figure(
    image("Protokoll 23.pdf", page: 1),
    caption: [Versuchsprotokoll],
)

= Auswertung
== Berechnen der Widerstände im Spannungsteiler
$U_B$ Batteriespannung $R_M$ Widerstand des Messgeräts Gesucht: $R$ Widerstand
der Spannungsteilerwiderstände (beide gleich)


=== Bei messung der Batteriespannung
Gesamtwiderstand bei Messung der Batteriespannung: $I_R_1$ strom durch den
widerstand bei dieser Messung
$ 1/R_"ges" = 1/R_m + 1/(2R) $
$ U_B = I_m_1 R_m = I_R_1 dot 2 R $
$ I_B_1 = I_m_1 + I_R_1 $
$ U_B = R_"ges" dot I_B_1 $

=== Bei Messung der Spannung an einem Widerstand
Sei $U_R_1$ die Spannung an dem Widerstand, an dem gemessen wird Sei $U_R_2$ die
Spannung an dem Widersand an dem nicht gemessen wird $I_B_2$ Gesamtstrom bei
dieser Messung $I_R_2$ Strom durch den Widerstand bei dieser Messung $R_"ges2"$
ist der gesamtwiderstand der parallelschaltung aus einem Widerstand und dem
Messgerät

$ 1/R_"ges2" = 1/R_m + 1/R <=> R_"ges2" = 1/(1/R_m + 1/R) $
$ I_B_2 = I_R_2 + I_m_2 $
$ U_R_1 = R_"ges2" dot I_B_2 = R_m dot I_m_2 = R dot I_R_2 $
$ U_B = U_R_1 + U_R_2 $
$ U_B = I_B_2 dot R + I_B_2 dot R_"ges2" = I_B_2 dot (R + R_"ges2") $

=== Rechnen:

$
    U_R_2 / R = U_R_1/R_"ges2" \
    (U_B - U_R_1) / R = U_R_1 dot (1/R_m + 1/R) \
    (U_B - U_R_1) = U_R_1 dot (R/R_m + 1) \
    (U_B - U_R_1)/U_R_1 - 1 = R/R_m \
    ((U_B - U_R_1)/U_R_1 - 1) dot R_m = R = qty("9.05+-0.25e2", "Ohm") \
$

== Messung mit dem Kompensator
=== Berechnen der Spannung
Wir haben mit der Eichspannung eingestellt, dass $500$ Skalenteile des
Kompensators der Eichspannung $U_e = qty("2.5000+-0.0005", "V")$ Spannung
entsprechen. Hier müssen wir mit


TODO Fehler Vernachlässigbar

Um die Werte, die wir an der Skala ablesen in Spannungen umzurechen, muss also
druch $200$ geteilt werden.

Hier müssen wir den Linearitätsfehler des Kompensationspotentiometers
miteinberechnen: $Delta_"lin" = 0.25%$. Man sieht dass, dieser Fehler deutlich
größer ist als der durch die Eichspannung, also kann $Delta U_e = 0.02%$
vernachlässigt werden.

#figure(
    table(
        columns: 3,
        [], [$U$ in Skt], [$U$ in V],
        [Batteriespannung $U_B$], [$qty(821.0, 0.2)$], num("4.106+-0.013"),
        [Widerstand 1 $U_R$], [$qty(410.9, 0.2)$], num("2.054+-0.013"),
        [Widerstand 2 $U_R$], [$qty(810.7, 0.2)$], num("2.054+-0.013"),
    ),
    caption: [Spannungswerte am Spannungsteiler],
)

Hier beachten wir noch zusätzlich den Ablesefehler der Skala von $0.2"Skt"$.

Nach der Maschenregel sollte für (TODO refernz zu zeichnung vom Spannungsteiler)
die Spannungen gelten:
$ U_B = 2 dot U_R $

Wir haben $2 dot U_R = qty("4.108+-0.018", "V")$. Damit haben wir eine
Abweichung von
$ z = abs(2 U_R - U_B)/((Delta(2 U_R))^2 + (Delta U_B)^2) = 0.092 $
Der Reststrom, der durch den Kompensator fließt ist also vernachlässigbar im
Vergleich zum Messfehler.

TODO Diskussion Maschenregel wird suber bestätigt




== Belastete Batterie
Wir haben hier wie oben beschrieben die Spannungswerte unter berücksichtigung
der Fehler von Skalenteilen in Volt umgerechnet.

Auch der Strom, den wir durch den Schiebewiderstand eingestellt haben, ist
Aufgrund der Ungenauigkeit unseres erweitereten Strommessgeräts Fehlerbehaftet.

TODO Referenz zeichnung von Parallelschaltung mit dem Strommessgerät

$ 1/R_m = 1/R_d + 1/R_e $
Hier bezeichnet $R_m$ den Widerstand des erweiterten Strommessgeräts, mit
$R_d = qty("448+-5", "Ohm")$ den Widerstand des Drehspulinstruments und mit
$R_e = qty("23.60+-0.04", "Ohm")$
#footnote[
    Der Fehler des Dekadenwiderstands ergibt sich aus den Fehlern der einzelnen
    Widerstände, die wir nach den Regeln der Gausschen Fehlerfortpflanzung
    addiert haben:
    $
        Delta R_e = sqrt((Delta_10)^2 + (Delta_1)^2 + (Delta_(0.1)^2)) = sqrt((0.2% dot 20 Omega)^2 + (0.5% dot 3 Omega)^2 + (1% dot 0.6 Omega)^2) = 0.04 Omega
    $

]
den Widerstand, der am Dekadenwiderstand eingestellt wurde um den Messbereich zu
erweitern.

Der Gesamtwiderstand dieser Parellelschaltung entspricht:

$ R_m = 1/(1/R_d + 1/R_e) = qty("22.42+-0.04", "Ohm") $
Die Fehler in dieser und in den anderen Formeln haben wir mit dem Python Package
`uncertainites` berechnet. Die Erweiterung des Messbereichs funktioniert nach
folgender Formel: (TODO referenz zu zeichnung von der Parallelschaltung von dem
Erweiterten Strommessgerät)

$ I = I_d + I_R $
Mit der Gesamtstromstärke $I$ die durch das Messgerät fließt, der im
Drehspulenmessgerät gemessenen Stromstärke $I_d$ und der Stromstärke $I_R$, die
im Erweiterungswiderstand abfällt.

Damit gilt:

$ U = I_d dot R_d $

$ I = I_d + U/R_e = I_d + I_d R_d/R_e = I_d (1 + R_d/R_e) $

Auf dem Drehspulenmessgerät ist für die abgelesene Stromstärke $I_d$ ein Fehler
von $Delta I_d = qty("0.25", "mA")$ angegeben. Insgesamt erhalten wir, unter
berücksichtung von den Fehlern $Delta R_d$ und $Delta R_e$ dann einen Fehler für
die gemessene Stromstärke von $Delta I = qty("5.0", "mA")$





#figure(
    image("Plot.svg"),
    caption: [$U(I)$ Diagramm für die belastete Batterie],
)<plot>

Für eine belastete Batterie gilt (TODO Referenz Einleitung):

$ I = U_q / (R_i + R_L) $
$ I R_i + I R_L = U_q $
Wir messen außen an der Batterie aber genau die Spannung am Lastwiderstand:
$ U = I R_L $
Damit haben wir:
$ U = U_q - I R_i $
Wir können also aus der Steigung von @plot den Innenwiderstand $R_i$ der
Batterie und aus dem y-Achsen abschnitt die Quellenspannung $U_q$ ablesen.


Wir haben die Regressionsgerade mit `scipy.optimize.curve_fit` bestimmt. Daraus
erhalten wir:

#align(
    center,
    rect[$ R_i = qty("2.56+-0.20", "Ohm") $
        $ U_q = qty("4.140+-0.02", "V") $
    ],
)


== Leistungsanpassung
Wir stellen zunächst $P$ auf und formen zu $P(R_L)$ um:
$
    P & = U(I) dot I \
      & = (U_q - I R_i) dot I \
      & = (U_q - (U_q)/(R_i + R_L) R_i) dot (U_q)/(R_i + R_L) \
      & = (1 - R_i/(R_i + R_L)) dot (U_q^2)/(R_i + R_L) \
$
Anschließend bilden wir die partielle Ableitung von $P$ nach $R_L$:

$
    (partial P)/(partial R_L) &= (-1 + R_i/(R_i + R_L)) dot U_q^2/(R_i + R_L)^2 + U_q^2/(R_i + R_L) dot R_i/(R_i + R_L)^2 \
    &= - U_q^2/(R_i + R_L)^2 + (2 R_i U_q^2)/(R_i + R_L)^3
$

Die Extremstelle können wir aus der Gleichung $(partial P)/(partial R_l) = 0$
bestimmen:

$
          0 & = - U_q^2/(R_i + R_L)^2 + (2 R_i U_q^2)/(R_i + R_L)^3 \
      <=> 0 & = (2 R_i)/(R_i + R_L) - 1 \
      <=> 0 & = (2 R_i) - R_i - R_L \
    <=> R_i & = R_L \
$
Die Nullstelle der Ableitung und damit das Maximum von $P(R_L)$ liegt bei
$R_L = R_i$. Die Klemmspannung beträgt dabei die Hälfte der Quellspannung :
$ U(I) = U_q - I R_i = U_q - (U_q R_i)/(2 R_i) = U_q/2 $



= Diskussion




