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
    title: "Spektralphotometrie",
    versuch_nr: "34",
    authors: (
        (
            name: "Christian Krause",
            email: "christian.krause\@stud.uni-heidelberg.de",
        ),
        (name: "Aaron Boheim", email: "aaron.boheim\@stud.uni-heidelberg.de"),
    ),
    tutor: "Catharina Lan Hock",
    date: "23.09.2026",
)

#set page(numbering: "1")

= Einleitung

== Ziel

In Versuch 34 werden wir mit einem Spektralphotometer einmal über die Variation
der Länge der Küvette und einmal über die Variation der Konzentration die
Molarextinktion der Farbe Brilliantblau messen.

== Physikalische Grundlagen

#figure(
    image("Absorptionsgesetz.png", width: 50%),
    caption: [Lambertsches Absorptionsgesetz],
)
Für die Intensität $I$ von Licht in einem Medium mit der Absorptionskonstante
$k$ gilt:

$ dif I = - k I dif l $

Durch Integration erhält man:

$ I = I_0 e^(-k l) $

mit der Anfangsintensität $I_0$. In der Praxis ist es einfacher den dekadischen
Absorptionskoeffizienten zu verwenden: $k' = k log e$.

Für verdünnte Lösungen der Konzentration $c$ gilt im Allgemeinen:
$ k' = epsilon c $<gl_epsilon>
mit der Molarextinktion $epsilon$.

Damit können wir für die Intensität $I$ schreiben:

$ I = I_0 10^(-k' l) = I_0 10^(-c epsilon l) $<gl_1>

= Durchführung

Die Durchführung wurde mit KI verfasst.
#line()

Zu Beginn wurde das Gitterspektrometer mit der Software OceanView gestartet und
die Lichtquelle eingeschaltet. Der Fasereinkoppler wurde symmetrisch
ausgeleuchtet. Anschließend wurde die Integrationszeit so eingestellt, dass das
Spektrum nicht in Sättigung war. Für die Messungen wurden jeweils 50 Scans
gemittelt. Zunächst wurde eine Referenzmessung ohne absorbierende Lösung
durchgeführt. Danach wurde die Lichtquelle ausgeschaltet und eine Dunkelmessung
aufgenommen, um den Dunkelstrom des Spektrometers zu berücksichtigen.
Anschließend wurde die Lichtquelle wieder eingeschaltet.

== Aufnahme des Absorptionsspektrums

Für die Bestimmung des Absorptionsspektrums wurde zunächst die 12 cm lange
Küvette in den Strahlengang gestellt. Das Spektrum wurde im Bereich von 430 nm
bis 660 nm betrachtet und die Wellenlänge des Absorptionsmaximums bestimmt.
Diese Wellenlänge wurde anschließend für die weiteren Messungen verwendet. Das
aufgenommene Absorptionsspektrum wurde gespeichert.

== Variation der Schichtdicke

Für die Messung der Absorption in Abhängigkeit von der Schichtdicke wurden die
Küvetten mit den Schichtdicken 1,5 cm, 3 cm, 6 cm, 12 cm und 24 cm verwendet.
Die kürzeste Küvette wurde zunächst in den Küvettenhalter eingesetzt und die
Intensität bei der zuvor bestimmten Wellenlänge eingestellt. Die
Integrationszeit wurde so gewählt, dass die Intensität an dieser Stelle gerade
noch nicht gesättigt war. Zusätzlich wurden 50 Scans gemittelt und anschließend
eine Dunkelmessung durchgeführt.

Danach wurde für jede Küvette die Intensität bei der festgelegten Wellenlänge
fünfmal gemessen. Dabei wurden die Küvetten jeweils rechts am Anschlag des
Küvettenhalters positioniert. Aus den Messwerten wurden später die Mittelwerte
und deren Fehler bestimmt.

Da die beiden längsten Küvetten den Strahlengang beeinflussen, wurde zusätzlich
bei den 12 cm und 24 cm langen Küvetten der Durchmesser der abgebildeten
Lochblende gemessen. Dazu wurde der Durchmesser einmal mit und einmal ohne
Küvette bestimmt.

== Variation der Konzentration

Für die Untersuchung der Abhängigkeit von der Konzentration wurde eine
rechteckige Küvette mit 21 ml VE-Wasser gefüllt und in den rechten
Küvettenhalter eingesetzt. Die Konzentration wurde anschließend schrittweise
erhöht, indem definierte Volumina der Brilliantblau-FCF-Lösung mit einer
Konzentration von $5 times 10^(-6) "mol/l"$ hinzugegeben wurden.

Zunächst wurde eine Nullmessung mit reinem VE-Wasser durchgeführt. Anschließend
wurden nacheinander $1,4 "ml"$, $1,6 "ml"$, $4,0 "ml"$ und $14,0 "ml"$ der
Brilliantblau-FCF-Lösung hinzugegeben. Nach jeder Zugabe wurde die Intensität
bei der zuvor bestimmten Wellenlänge fünfmal gemessen. Die Integrationszeit
wurde dabei so eingestellt, dass das Spektrum gerade noch nicht in Sättigung
war. Auch für diese Messungen wurden jeweils 50 Scans gemittelt und zuvor eine
Dunkelmessung durchgeführt.

Die gemessenen Intensitäten wurden anschließend gemeinsam mit den Messwerten aus
der Variation der Schichtdicke in ein halblogarithmisches Diagramm eingetragen.
Für die Konzentrationsmessungen wurde dabei eine zusätzliche lineare
Abszissenskala für die Konzentration verwendet.

= Versuchsprotokoll

#figure(
    grid(
        columns: 2,
        image("Versuchsprotokoll.pdf", page: 1, width: 65%),
        image("Versuchsprotokoll.pdf", page: 2, width: 65%),

        image("Versuchsprotokoll.pdf", page: 3, width: 65%),
    ),
    caption: [Versuchsprotokoll],
)

= Auswertung

#figure(
    image("Auswertung_Diagramm.pdf", page: 2),
    caption: [Die Diagramme mit Fehlergeraden und Steitungsdreieck],
)

== Absorption als Funktion der Schichtdicke

Wir können die Steigung auf halblogarithmischen Papier durch folgende Formel
berechnen:

$ m = (log(y_2) - log(y_1))/(x_2 - x_1) = log(y_2 / y_1)/(x_2 - x_1) $

Die Steigung der ersten Geraden enstpricht der Absorptionskonstante $k'$ (siehe
@gl_1). Aus dem Diagramm können wir ablesen:
$k' = qty("0.112+-0.011", "cm^-1")$. Den Fehler haben wir bestimmt, in dem wir
die Steigung der beiden Fehlergeraden ablgesen haben und die größere Abweichung
zu dem Wert von $k'$ verwendet haben.

Aus dem Skript erhalten wir eine Konzentration der Lösung von
$c = qty("1e-6", "mol/l")$. Damit können wir die Molarextinktion $epsilon$
(siehe @gl_epsilon) berechnen:

#rect[$ epsilon = k'/c = qty("1.12+-0.11e5", "l mol^-1 cm^-1") $]

== Absorption als Funktion der Konzentration

Wir erhöhen bei konstanter Schichtdicke Konzentration schrittweise, in dem wir
zu dem Wasservolumen $V_0 = qty(21, "ml")$ schrittweise die Volumina
$V_1, dots V_4$ einer Brilliantblau FCF Lösung der Konzentration
$tilde(c) = qty("5e-6", "mol/l")$ hinzufügt.

Man berechnet die Konzentration $c_i$ dann durch:

$
    c_i = tilde(c) (sum_(j = 1)^(i) V_i) / (sum_(j = 0)^i V_i) quad "für" i in [|1,5|]
$

Wir nehmen hier an, dass wir das Volumen immer mit einer Genauigkeit von
$Delta V = qty(0.1, "ml")$ abmessen können:

#figure(
    table(
        columns: 2,
        [], [Konzentration in mol/l],
        $c_0$, $0$,
        $c_1$, num("3.12+-0.21e-7"),
        $c_2$, num("6.25+-0.26e-7"),
        $c_3$, num("1.250+-0.024e-6"),
        $c_4$, num("2.500+-0.013e-6"),
    ),
    caption: [Konzentrationen der Brilliantblau Lösung],
)

Im zweiten Graph variieren wir die Konzentration, d.h. wir können
$m = epsilon l$ (siehe @gl_1) ablesen:

$ m = epsilon l = qty("1.64+-0.11e5", "l/mol") $

Mit der Schichtdicke $l = qty(1.5, "cm")$ können wir die Molare Extinktion
$epsilon$ berechnen:

#rect[$ epsilon =m/l = qty("1.09+-0.07e5", "l/mol/cm") $]

= Ergebnisse

Wir haben zwei Werte für $epsilon$ berechnet:

#figure(
    table(
        columns: 4,
        [],
        [Variation der Schichtdicke],
        [Variation der Konzentration],
        [Abweichung $z$],

        [$epsilon$ in $"l"^(-1) "mol"^(-1) "cm"^(-1)$],
        num("1.12+-0.11e5"),
        num("1.09+-0.07e5"),
        $0.23 sigma$,
    ),
)<tab_ergebnisse>

Um die Werte zu vergleichen haben wir die Abweichung
$
    z = abs(epsilon_1 - epsilon_2)/sqrt((Delta epsilon_1)^2 + (Delta epsilon_2)^2)
$
berechnet.

= Diskussion

Man sieht in @tab_ergebnisse, dass beide Werte für $epsilon$ innerhalb ihrer
Fehlerbereiche übereinstimmen.

== Variation der Länge

Im ersten Versuchsteil ist uns aufgefallen, dass sich die Intensität stark
ändert, wenn man die Küvetten dreht. Eine mögliche Ursache wäre hier eine
(ungleichmäßige) Verschmutzung der Scheibe (innen oder außen). Auch die
Absorption der Scheibe haben wir vernachlässigt, um diese vollständig zu
berücksichtigen wäre noch eine Messung mit leerer Küvette notwendig gewesen.

== Variation der Konzentration

Eine mögliche Fehlerquelle beim zweiten Versuchsteil sind kleine Luftbläschen,
die sich beim Einfüllen gebildet haben. Auch in diesem Teil könnte die Küvette
verschmutzt gewesen sein.
