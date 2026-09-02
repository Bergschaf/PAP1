#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")

= Introduction
== Goal
- Determination of directing Torque with two different Methods
- Determination of Moment of Inertia of Irregularly Shaped Bodies
- Showing Steiner's Theorem

== Physical Foundation

- Rückstellkraft Feder pendel
-> Directing Torque Rotary Pendulum
- EOM Rotary Pendulum
- Formula for Period of Rotary Pendulum
- Bisschen rumrechnen

- Steiner's Theorem

= Messprotokoll

== Sketch of the Experiment
#figure(
    image("Sketch.png"),
    caption: [Sketch of the experiment],
)
= Auswertung

== Determination of the Directing Torque

=== Method 1
To determine the directing torque statically, we measured the angle with verious
weights pulling on a disk via a pully.

First, we need to calculate the torque that each weight exerts on the Pendulum
using the following formula (The radius of the disk is 5cm):
$ M = m * g * 5 "cm" $
We found out online that the scale has an error of $plus.minus 1g$ and we
assumed the error during the experiment to be at least 1°, with some
measurements having a bigger error due to static friction at the equilibrium.
There, we could not be sure where the true equilibrium was, because the pendulum
would not move in a range of a few degrees. We noted this in our protocoll when
this was the case.

We chose to ignore the error that the scale contributes to the Torque
measurement, because it is a lot smaller than the error of the angle
measurement.

#figure(
    image("Aufgabe1.svg"),
    caption: [Plot of the Angle to],
)

Slope: $a_1 = num("43.10+-0.32") "rad"/("Nm")$ (Determined using `scipy`)

From this we can calculate the Directing Torque:

#rect[$ D_1 = 1 / a_1 = qty("0.02320+-0.00017", "N m / rad") $<D_1>]

=== Method 2

For our second measurement of the Directing Torque, we measured the Period of
the Pendulum with and without a Disk with known Moment of Inertia.

The Disk has a mass of $qty("542+-1", "g")$ and a Radius of
$qty("525.5+-0.25", "mm")$. The uncertainties are from the scale and from the
caliper.

Using the Formula for the Moment of Inertia of a Disk, we get
$ J_S = 1/2 m_s r_s^2 = qty("0.000748+-0.000007", "kg m^2") $

We used python package `uncertainties` to calculate the Error, by hand we have
to calculate the total derivative of $J_s$:

$ dif J_s = 1 / 2 r_s^2 dif m + m_s r_s dif r_s $
Using the Laws of error propagation, we get:
$
    Delta J_s = sqrt((1/2 r_s^2 Delta m)^2 + (m_s r_s Delta r_s)^2) approx 7.3 dot 10^(-6) "kg" "m"^2
$

We measured the Time of 20 Periods using a Stoppwatch (error negligble). We
estimated the error due to our Reaction time to be about $qty("200", "ms")$.

We added this (according to the rules of error propagation) to the average error
of the mean value $S_M = S_e / sqrt(N)$ (determined from the 3 measurements):
$ Delta T = sqrt((qty(200, "ms"))^2 + S_M^2) $

For our measurements, we got a Period of

$ "Without Disk:" T_1 = qty("1.222 +- 0.010", "s") $
$ "With Disk:" T_2 = qty("1.687+-0.019", "s") $

As discussed in the Introduction, we have the following Formulas for $T_1$ and
$T_2$ (assuming $J_T$ to be the moment of inertia of the table):
$ T_1 = 2 pi sqrt(J_T / D) $
$ T_2 = 2 pi sqrt((J_S + J_T) / D) $

We can solve both equations for $J_T$:

$ J_T = D T_1^2 / (4 pi^2) $<J_eq>
$ J_T = D T_2^2 / (4 pi^2) - J_s $

This gives us:

$ D T_1^2 / (4 pi^2) = D T_2^2 / (4 pi^2) - J_s $

$ (4 pi^2 J_s)/D = T_2^2 - T_1^2 $

$ D = (4 pi^2 J_s)/(T_2^2 - T_1^2) $<D_eq>

After substituting the values, we get:

#rect($ D_2 = qty("0.0218+-0.0011", "N m /rad") $)

=== Error Propagation by Hand

$
    dif D = (4 pi^2)/(T_2^2 - T_1^2) dif J_s + (4 pi^2 J_s) ((2 T_1 dif T_1) / (T_2^2 - T_1^2)^2 - (2 T_2 dif T_2) / (T_2^2 - T_1^2)^2)
$

$
    Delta D = sqrt(((4 pi^2)/(T_2^2 - T_1^2) Delta J_s)^2 + (4 pi^2 J_s)^2 (((2 T_1 Delta T_1) / (T_2^2 - T_1^2)^2)^2 + ((2 T_2 Delta T_2) / (T_2^2 - T_1^2)^2)^2))
$
(We actually verified it by hand that the result matches with the one from
python, it was not fun...)

== Moment of Ineratia of Irregular Shape

To determine the Moment of Intertia of the Irregular Shape $J_u$, we did the
same procedure as above to determine the Period along with its error:
$ T_u = qty("2.319+-0.010", "s") $

From rearranging the Formula above, we get

#rect[$
    J_u = D / (4 pi^2) * (T_u^2 - T_1^2) = qty("0.002283+-0.000035", "kg m^2")
$]

The error propagation works analogously to the exercise above.

== Steiners Theorem

After calculating the average value and incorporating the statistical and
reaction time error, we measured the following Periods:

#table(
    columns: 2,
    [*Distance* $a$ to the center of mass in mm], [*Period* $T_u$ in s],
    [5], num("2.32+-0.01"),
    [10], num("2.33+-0.01"),
    [20], num("2.39+-0.01"),
    [30], num("2.49+-0.01"),
    [40], num("2.64+-0.02"),
)

We can now calculate the moments of inertia by rearranging @D_eq to:

$ J_i_e = D/ (4 pi^2) * (T_2^2 - T_1^2) $
(With $J_i_e$ being the experimentally determined moment of intertia.)

By using our best known value of $D$ (obtained in @D_1) and our known value of
$T_1$, we can get the different moments of inertia by setting $T_2$ to the
different values of $T_u$ corresponding to the distances from the center of
mass.

Additionally, we used Steiner's Theorem to calculate the moment of inertia
$J_i_S$ for the various distances $a_i$ from the center of mass:

$ J_i_S = J_u + M dot a_i^2 $

#table(
    columns: 3,
    [*Distance* $a$ to the center of mass in mm], [$J_i_e$], [$J_i_S$],
    num("5.0"), num("0.002288+-0.000035"), num("0.002299+-0.000035"),
    num("10.0"), num("0.002309+-0.000035"), num("0.002349+-0.000035"),
    num("20.0"), num("0.00247+-0.00004"), num("0.002549+-0.000035"),
    num("30.0"), num("0.00275+-0.00004"), num("0.002881+-0.000035"),
    num("40.0"), num("0.00321+-0.00006"), num("0.003347+-0.000035"),
)

Plotting these values as a function of $a^2$ yields the following plot:

#figure(
    image("Aufgabe6.svg"),
    caption: [Moment of Inertia as a function of the distance to the center of
        mass squared],
)<Steiner_schlecht>



= Results


#rect[$ D_1 = qty("0.02320+-0.00017", "N m / rad") $

    $ D_2 = qty("0.0218+-0.0011", "N m /rad") $
]
zwei werte für D


#rect[$
    J_u = qty("0.002283+-0.000035", "kg m^2")
$]

TODO wert für moment of inertia


= Discussion

== Directing Torque

We determined the directing torque of the spring with two different methods. The
standardized Difference is
$ beta_D = (D_1 - D_2) / sqrt(sigma_1^2 + sigma_2^2) approx 1.26 $
This indicates that the wo values are well inside the error range of each other.


Next, I am going to point out possible sources of Error that we did not account
for:
=== Possible Sources of Error for $D_1$
- Friction in the pully and the bearing of the pendulum
=== Possible Sources of Error for $D_2$
- Systematic error in the time measurement

== Moment of Intertia
To estimate if our value is plausible, I calculated the radius that a disk with
the same moment of inertia would have using the following formula:
$ R_"equiv" = sqrt((2 J_u)/M) approx 9.2 "cm" $
This seems plausible, because the irregular shape had some parts with smaller
radius, but also some with bigger radius.

== Steiners Theorem

We can observe in @Steiner_schlecht, that the experimentially determined values
deviate from the expected values.

A likely cause could be the inaccuracy of the measurement of the center of mass.
To investigate this, we plotted the values again after subtracting and adding a
few milimeters to the Distance. In the following Plot we shifted the Distance
towards the center of mass by 3mm:

#figure(
    image("Aufgabe6_shift.svg"),
    caption: [Moment of Inertia as a function of the distance to the center of
        mass squared (with the distance shifted towards the center of mass by
        3mm)],
)
We can see that the experimental data fits the calculation a lot better here.
Possible explanations for this error could be:
- inaccurate marking of the center of mass
- inaccurate positioning of the shape on the pendulum (unlikely, because not
    systematic)
- inaccurate marking of the distances from the center of mass (unlikely, because
    not systematic)

