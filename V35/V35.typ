#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange

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

TODO Bildquellen

In @real sieht man die Spannungsquelle einer realen Fotozelle. Es fällt auf,
dass der maximale Fotostrom nicht direkt bei $U = 0V$ erreicht wird. Das liegt
daran, dass die Geschwindigkeit der ausgelösten Elektronen nicht immer genau in
Richtung der Anode zeigt, in manchen Fällen wird eine Saugspannung $U > 0$
benötigt, um das Elektron umzulenken.

In unserem Versuchsaufbau ist außerdem zu beachten, dass $I$ proportional zu
$U^2$ ist (aufgrund der Geometrie von Anode und Kathode).

An der Sperrspannung $U_s$ gilt dann:
$ e U_s = E_"kinmax" = h nu - A prop sqrt(I) $


= Protokoll

= Auswertung


= Diskussion

Hypothese: Netzgerät hat einen Nichtlinearen Fehler, der stärker ist, je
negativer die Spannung ist (weil die Kurven bei denen die Spannung nicht so
klein war passen besser als die Kurven mit sehr negativer Spannung).


