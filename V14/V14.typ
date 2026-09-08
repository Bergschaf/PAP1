#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")

= Einleitung

== Ziel

In diesem Versuch geht es darum, die Erdbeschleunigung über ein Fadenpendel zu
messen und dabei mehrere Korrekturfaktoren zu berücksichtigen und deren Einfluss
zu messen.

== Physikalische Grundlagen
Für die Periodendauer $T_D$ einer Drehschwingung gilt:

$ T_D = 2pi sqrt(J/D) $<T_D>
mit dem Trägheitsmoment $J$ bzgl. der Drehachse und der Winkelrichtgröße $D$ des
Pendels (analog zur Rückstellkraft bei einem linearen Pendel). Für das
Trägheitsmoment erhalten wir mit dem Steinernen Satz:
$ J = J_K + J_F = 2/5 m_K r^2 + m_k l^2 + 1/3 m_F l'^2 $
mit der Kugelmasse $m_K$, dem Radius $r$ der Kugel, der Masse $m_F$ des Fadens
und der Fadenlänge $l'$ (Pendellänge: $l := l' + r$).

Für das Rücktreibende Drehmoment erhalten wir unter der Berücksichtigung von dem
Auftrieb der Kugel:

$ M = -((m_K - rho_L V_K)g l sin phi - 1/2 m_F g l' sin phi) $
Mit der Kleinwinkelnäherung $sin phi approx phi$ erhalten wir:

$ M = -(m_K(1 - rho_L/rho_K) + 1/2 m_F) g l phi $

Ein Koeffizientenvergleich mit $M = - D phi$ ergibt:

$ D = m_K g l [1 - (rho_l/rho_k - 1/2 m_F/m_K)] $

Um das in @T_D einzusetzen schätzen wir zunächst ab:

$
    J/D &= (2/5 m_K r^2 + m_K l^2 + 1/3 m_F l'^2)/(m_K g l [ 1- (rho_l/ rho_k - 1/2 m_F/m_K)]) \
    &= 1/g (r^2 / l + l + 1/3 m_F / m_K l'^2 / l)/(1 - (rho_l / rho_K - 1/2 m_F / m_K)) \
    "Näherung:" 1/(1 - epsilon) approx 1 + epsilon "für" epsilon << 1 \
    &approx 1/g (1 + (rho_l / rho_K - 1/2 m_F / m_K))(r^2 / l + l + 1/3 m_F / m_K l'^2 / l) \
    &= l/g (1 + (rho_l / rho_K - 1/2 m_F / m_K))(r^2 / l^2 + 1 + 1/3 m_F/ m_K l'^2 / l^2) \
    "Näherung:" l'^2 / l^2 approx 1 \
    &approx l/g (1 + (rho_l / rho_K - 1/2 m_F / m_K))(r^2 / l^2 + 1 + 1/3 m_F/ m_K) \
    &= l/g [(r^2 / l^2 + 1 + 1/3 m_F/ m_K) + (rho_l / rho_K - 1/2 m_F / m_K) + (rho_l / rho_K - 1/2 m_F / m_K)(r^2/l^2 + 1/3 m_F/ m_K)] \
    & "Näherung: Der letzte Summand wird vernachlässigt" \
    &approx l/g [1 + r^2 / l^2 - 1/6 m_F/ m_K) rho_l / rho_K)] \
$

Damit erhalten wir als erste Abschätzung für die Periodendauer:


$ T_1^2 = 4 pi^2 l/g (1 + 2/5 r^2/l^2 + rho_L/rho_K - 1/6 m_F/m_K) $

Korrekturterme:

$ K_delta = delta^2 / omega_0^2 $
$ T_2^2 = T_1^2 (1 + K_delta) $
$ K_a = phi_0^2 / 8 $
$ T_3^2 = T_2^2 (1 + K_a) $

== Korrekturfaktor für die Amplitude
Wir haben in (TODO Reference) der Einleitung bereits festgestellt, dass für eine
Periodendauer mit der maximalen Auslenkung $phi_0$ in erster nährerung der
Korrekturfaktor $K_a (phi_0) = phi_0^2/8$ eingesetz werden kann:
$ T_3^2 = T_2^2 (1 + K_a (phi_0)) = T_2^2 (1+ phi_0^2/8) $

Da die Amplitude im laufe des Experiments aber exponentiell abnimmt, nimmt auch
der Korrekturfaktor ab.

Sei $phi_i$ die Amplitude (maximale Auslenkung innerhalb einer Periode) der
$i$-ten Periode und $T_i$ die dauer der $i$-ten Periode: Damit gilt
$ (T_i)^2 = T_2^2 (1 + K_a (phi_i)) $<T_i_quadrat>
Es gilt also: Wir können die gesamte gemessene Zeit als Summe der einzelnen
Perioden darstellen (Damit ist $T_4$ die durchschnittliche Periodendauer aus
allen Perioden):
$ T_4 = 1/N sum_(i = 1)^N T_i $

Betrachten wir folgenden Term:

$
    sum_i^N (T_i - T_4)^2 & = sum_i^N (T_i^2 - 2T_i T_4 + T_4^2) \
                          & = sum_i^N T_i^2 - sum_i^N 2 T_i T_4 + sum_i^N T_4^2 \
                          & = sum_i^N T_i^2 - 2 T_4 sum_i^N T_i + N T_4^2 \
                          & "Es gilt per Definition " sum_i^N T_i = N T_4 \
                          & = sum_i^N T_i^2 - 2 N T_4^2 + N T_4^2 \
                          & = (sum_i^N T_i^2) - N T_4^2 \
                          & = (sum_i^N T_i^2) - (sum_i^N T_i)^2 \
$

Wir haben also:
$ (sum_i^N T_i)^2 = sum_i^N T_i^2 - sum_i^N (T_i - T_4)^2 $<geile_gleichung>

Wir nehmen an, dass die Varianz der Periodendauern klein ist:
$ "Var"(T) = sum_i^N (T_i - T_4)^2 << 1 $
Damit können wir mit @geile_gleichung folgende abschätzung treffen:

$
    (1/N sum_(i = 1)^N T_4^i)^2 approx 1/N^2 dot N sum_(i = 1)^N (T_4^i)^2
$<quadrat_approx>
Diese können wir hier zusammen mit @T_i_quadrat anwenden:
$
    T_4^2 approx
    1/N sum_(i = 1)^N (T_4^i)^2= 1/N sum_(i = 1)^N T_2^2 (1 + K_a (phi_i)) = T_2^2(1 + 1/N (sum_(i = 1)^N K_a (phi_i)))
$

Wenn sich die Amplitude während der Messung stark verändert, ist es also genauer
also Korrekturfaktor den Durchschnitt über alle Korrekturfaktoren zu verwenden:
$ K_a' = 1/N (sum_(i = 1)^N K_a (phi_i)) $

TODO Korrekturfaktor abschätzen

Damit haben wir am Ende:

$
    T_g^2 = (4 pi^2 l)/g (1 + 2/5 r^2/l^2 + rho_L/rho_K - 1/6 m_F/m_K + delta^2/omega_0^2 + 1/N (sum_(i=1)^N phi_i^2/8))
$


== Durchführung

TODO

= Protokoll

#figure(
    image("Protokoll 14.pdf", page: 4),
    caption: "Veruchsprotkoll",
)
== Skizze


TODO

= Auswertung

== Erste Nährerung für g

=== Bestimmung der Länge

Um die Länge möglichst genau zu messen, haben wir den Abstand von der Aufhängung
des Fadens zur Ober- und Unterkannte der Kugel jeweils drei mal gemessen. Dabei
gehen wir von einem Messfehler von $Delta l = qty("1.0", "mm")$ aus.

Aus diesen Messungen haben wir den Fehler des Mittelwerts berechnet (TODO
Formel) und entsprechend der Gaußschen Fehlerfortpflanzung auf den Fehler
$Delta l$ addiert.

TODO genauer Am ende Erhalten wir aus dem Durchchschnitt der Länge der ober- und
unterkante der Kugel eine Pendellänge
$ l = qty("0.9257+-0.0010", "m") $


=== Bestimmen der Massen
Um die Masse der Kugel abzuschätzen haben wir den Durchmesser
$d_K = qty("24.00+-0.05", "mm")$ der Kugel mit der Schieblehre gemessen um das
Volumen zu bestimmen und sind von einer Dichte
$rho_K := rho_"Fe" = qty("7.874e3", "kg/m^3")$ ausgegangen. Damit erhalten wir
für die Masse der Kugel:
$ m_K = qty("5.69+-0.04e-2", "kg") $



Mit dem Radius des Fadens $r_"Faden" = qty("0.1", "mm")$, der Dichte
$rho_"Faden" := rho_"Fe"$ und der Länge $l' = qty("0.914+-0.001", "m")$ erhalten
wir über das Volumen eines Zylinders für die Masse des Fadens:
$ m_F = qty("2.257+-0.004e-4", "kg") $

Für die Dichte von Luft haben wir den Literaturwert
$rho_L = qty("1.204", "kg/m^3")$ verwendet.

Damit können wir eine erste approximation $g$ berechnen:


$
    g_1 = (4 pi^2 l)/(T_1^2) (1 + 2/5 r^2/l^2 + rho_L/rho_K - 1/6 m_F/m_K) = qty("9.805+-0.011", "m/s^2")
$

Die Fehler haben wir mit dem Python package `uncertainties` berechnet. Später im
Protokoll gehe ich noch darauf ein, wie man den Fehler von Hand berechnen kann.

== Bestimmung der Dämpfung $delta$
Um die Dämpfung zu bestimmen haben wir im Abstand von 25 Perioden auf einer
bestimmten Höhe ($h_m = qty("0.858+-0.002", "m")$) #footnote[Der Fehler der
    Messhöhe kommt daher, dass wir die Höhe der Unterkannte der Skala auf der
    horizontalen Messlatte abschätzen mussten. Das wird dadurch erschwärt, dass
    die Skala nicht die ganze Messlatte ausfüllt.] den Abstand des Fadens zur
Ruhelage notiert, diesen in die Amplitude $a$ umgerechnet
#footnote[$tan(a) = a_m/h_m$ mit der gemessenen Auslenkung $a_m$] und geplotted.
#figure(
    image("Plot1.svg"),
    caption: [Amplitude logarithmisch als Funktion der Zeit],
)<plot1>
Wir haben `scipy.optimize.curve_fit` verwendet um durch lineare Regression den
Wert für $delta$ (siehe gleichung TODO) zu bestimmen:

$ delta = qty("7.00+-0.85e-4", "/s") $

TODO chi quadrat vom fit

== Korrekturterm Dämpfung $delta$
Um den Korrekturterm für die Dämpfung zu bestimmen, berechnen wir zunächst
$ omega_0 = (2 pi)/T $
$ K_delta = delta^2 / omega_0^2 = num("4.63+-0.23e-8") $

== Korrekturterm Amplitude

Mit der maximalen Amplitude $phi_0 = 11.47 °$ erhalten wir:
$ K_a = phi_0^2/8 = num("5.46e-3") $

Wie wir bereits in der Einleitung festgestellt haben überschätzt dieser
Korrekturfaktor die Korrektur stark, da die Auslenkung im laufe des Versuchs
stark abfällt.

Refrenz gleichung TODO Einführung

$ K_a' = num("2.21e-3") $

== Fehler für g

Theoretisch könnte man den Fehler von $g$ über die totale Ableitung von $g$
bzgl. allen auftretenden Variablen bestimmen. Dieser Term ist allerdings sehr
unübersichtlich und die meisten Faktoren haben keinen Einfluss auf den Fehler
$Delta g$. Um den Fehler sinnvoll abzuschätzen, benennen wir im Folgenden die
summe aller Korrekturterme mit $K$:
$
    K := 2/5 r^2/l^2 + rho_L/rho_K - 1/6 m_F/m_K + delta^2/omega_0^2 + 1/N (sum_(i=1)^N phi_i^2/8)
$

$ g = (4 pi^2 l)/(T_1^2)( 1+ K) $

$
    dif g = 4 pi^2 ( (dif l)/ T_1^2 - (2 l T_1)/(T_1^3) dif T_1) + d K dots
$
Aus der totalen ableitung von $g$ ergibt sich nach der Gaußschen
Fehlerfortpflanzung:
$
    (Delta g) / g = (4 pi^2 sqrt((1/T_1^2 Delta l)^2 + ((2l T_1)/T_1^2 Delta T_1)^2 + (Delta K dots)^2)) / g
$


$
    (Delta g) / g = sqrt((1/T_1^2 (Delta l)/(l/T_1^2 (1 + K)))^2 + (((2 l T_1)/T_1^2 Delta T_1)/(l/T_1^2 (1 + K)))^2 + (Delta K dots)^2/g^2)
$
Wir nehmen im Folgenden an, dass die Korrekturterme klein sind und wir dadurch
den Relativen Fehler der Korrekturterme vernachlässigen können: #footnote[In der
    Ergebnisdiskussion habe ich explizit alle Korrekturterme ausgerechnet, dort
    sieht man, dass siese Abschätzung gut funktioniert.]
$ (Delta "Korrektur")^2 / g^2 <<< (Delta g)/g $
Außerdem nehmen wir für die weitern Umformungen an:
$ a / (1 + K)^2 approx a quad forall a $
Damit erhalten wir am ende für den Relativen Fehler von $g$:

$ (Delta g) / g = sqrt(((Delta l)/l)^2 + (2 T_1 Delta T_1)^2) $

= Ergebnisse
Um unsere Ergebnisse mit dem Literaturwert zu vergleichen, haben wir die
statistische Signifikanz berechnet.

$ beta_g = (g_i - g_r) / sqrt(Delta g_i^2 + Delta g_l^2) $
#figure(
    table(
        columns: 3,
        [], [ g in $m/s^2$], [Signifikanz $beta_g$],
        [Erste Näherung], num("9.805+-0.011"), $-0.44$,
        [Korrektur für Dämpfung mit $K_delta$], num("9.805+-0.011"), $-0.44$,
        [Korrektur für Amplitude $K_a$ (mit $phi_0$)],
        num("9.859+-0.011"),
        $4.92$,

        [Genauere Korrektur für Amplitude $K_a'$ (mit $phi_i$)],
        num("9.827+-0.011"),
        $1.73$,
    ),
    caption: [Ergebnisse und Statistische Signifikanz],
)

#figure(
    table(
        columns: 2,
        [$K_delta$], num("4.62+-1.13e-8"),
        [$K_a$], num("5.46+-0.06e-3"),
        [$K_a'$], num("2.21+-0.18e-3"),
    ),
    caption: [Korrekturfaktoren],
)<table_korrektur>

== Dämpfung

#rect[
    $ delta = qty("7.00+-0.85e-4", "/s") $
]

= Diskussion

== Fehler der Korrekturfaktoren

Da wir alle Werte mit dem Python package `uncertainties` ausgerechnet haben,
können wir auch für die Korrekturfaktoren Fehler angeben. Sie sind im Vergleich
zu dem Messfehler von $g$ sehr klein und leisten daher auch keinen beitrag zu
$Delta g$. Trotzdem ist es interessant zu sehen, wie genau wir die
Korrekturfaktoren theoretisch bestimmen können.

Bei dem Korrekturfaktor $K_a'$ habe ich bei der Fehlerbetrachtung den Fehler der
Abschätzung @quadrat_approx nicht miteinbezogen.

== Erste Näherung

Der Wert der ersten Näherung stimmt bereits mit einer Signifikanz von $0.44$ mit
dem Literaturwert überein.


=== Fehlerquellen

=== Dämpfung
Die Luftreibung wurde in der ersten Näherung nicht berücksichtigt. Sie erhöht
die Periodendauer, wodurch der berechnete Wert von $g$ größer wird, wenn man die
Luftreibung berücksichtigt.

In der Praxis sieht man jedoch, dass der Korrekturfaktur für die Dämpfung in der
Größenordnung $10^(-8))$ (siehe @table_korrektur) deutlich kleiner als der
Messfehler ist und daher vernachlässigt werden kann.

=== Amplitude
Die einfache Näherung der Bewegungsgleichung nimmt an, dass
$sin(phi) approx phi$ für kleine Winkel gilt.



Hier hängt es davon ab, welche Annahmen man für den Korrekturfaktor trifft:

Wenn man annimmt das die Amplitude bei der Anfangsfrequenz konstant bleibt,
erhält man einen sehr großen Korrekturfaktor, der zwar für die ersten Perioden
stimmt, aber dann nach einiger Zeit deutlich zu groß ist. Der resultierende Wert
für $g$ ist mit einer Signifikanz von $5.92$ vom Literaturwert entfernt.

Der genauere Korrekturfaktor $K_a'$ ist etwas kleiner als $K_a$ und führt zu
einem Wert von $g$, der mit einer Signfikanz von $1.73$ vom Literaturwert
entfernt ist. Dieser genauere Korrekturfaktor ist allerdings schwieriger zu
berechnen, da über alle Perioden iteriert werden muss.



== Weitere Fehlerquellen
- Nichtlineare Reibung: Wir haben nur die Reibung proportional zu $dot(phi)$
    beachtet, die Luftreibung hat aber auch quadratische und kubische
    komponenten. Man sieht auch in @plot1, dass die amplitude nicht nur
    exponentiell abnimmt, sondern dass auch andere Faktoren im Spiel sind.

- Luftreibung des Fadens

- Äußere Störfaktoren
    - Luftstrom im Raum
    - Wackeln am Tisch
    - Atmen





=== Möglichkeiten für eine genauere Messung
- größere Masse verwenden -> kleinere Dämpfung -> Effekte der kleinen Amplituden
    treten nicht so stark auf
- Versuch in einem isolierten, luftleeren Raum druchführen
- Zeitmessung automatisieren

- Genauere Längenmessung des Fadens bzw. ein längerer Faden, der den relativen
    Fehler reduziert


