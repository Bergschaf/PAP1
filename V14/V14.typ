#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")

= Einleitung


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



Damit haben wir am Ende:

$
    T_g^2 = (4 pi^2 l)/g (1 + 2/5 r^2/l^2 + rho_L/rho_K - 1/6 m_F/m_K + delta^2/omega_0^2 + 1/N (sum_(i=1)^N phi_i^2/8))
$


= Auswertung

== Erste Rechnung für g


$
    g_1 = (4 pi^2 l)/(T_1^2) (1 + 2/5 r^2/l^2 + rho_L/rho_K - 1/6 m_F/m_K) = qty("9.805+-0.011", "m/s^2")
$

== Korrekturterm Auftrieb

????

== Bestimmung der Dämpfung $delta$
Um die Dämpfung zu bestimmen haben wir im Abstand von 25 Perioden auf einer
bestimmten höhe den Abstand des Fadens zur Ruhelage notiert, diesen in die
Amplitude umgerechnet und geplotted. #figure(
    image("Plot1.svg"),
    caption: [Amplitude logarithmisch als Funktion der Zeit],
)<plot1>
Wir haben `scipy.optimize.curve_fit` verwendet um durch lineare Regression den
Wert für $delta$ (siehe gleichung TODO) zu bestimmen:

$ delta = qty("7.00+-0.85e-4", "/s") $

== Korrekturterm Dämpfung $delta$
Um den Korrekturterm für die Dämpfung zu bestimmen, berechnen wir zunächst
$ omega_0 = (2 pi)/T $
$ K_delta = delta^2 / omega_0^2 = num("4.63+-0.23e-8") $

== Korrekturterm Amplitude

Mit der maximalen Amplitude $phi_0 = 11.47 °$
$ K_a = phi_0^2/8 = num("5.46e-3") $

Wie wir bereits in der Einleitung festgestellt haben überschätzt dieser
Korrekturfaktor die Korrektur stark, da die Auslenkung im laufe des Versuchs
stark abfällt.

Refrenz gleichung TODO Einführung

$ K_a' = num("2.21e-3") $

== Fehler für g

Wir bennen im Folgenden die summe aller Korrekturterme mit $K$:
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
den Relativen Fehler der Korrekturterme vernachlässigen können:
$ (Delta "Korrektur")^2 / g^2 <<< (Delta g)/g $
Außerdem nehmen wir für die weitern Umformungen an:
$ a / (1 + K)^2 approx a quad forall a $

$ (Delta g) / g = sqrt(((Delta l)/l)^2 + (2 T_1 Delta T_1)^2) $

= Ergebnisse

TODO statistische Signifikanz
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
)

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


== Korrekturwerte
=== Dämpfung
Die Luftreibung wurde in der ersten Näherung nicht berücksichtigt. Sie erhöht
die Periodendauer, wodurch der berechnete Wert von $g$ größer wird, wenn man die
Luftreibung berücksichtigt.

In der Praxis sieht man jedoch, dass der Korrekturfaktur für die Dämpfung in der
Größenordnung $10^(-8))$ TODO Referenz Gleichung... deutlich kleiner als der
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
einem Wert von $g$, der nur noch mit einer Signfikanz von $1.73$ vom
Literaturwert entfernt ist.



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


