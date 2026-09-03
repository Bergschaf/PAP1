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
    title: "Moment of Intertia",
    versuch_nr: "12",
    authors: (
        (
            name: "Christian Krause",
            email: "christian.krause@stud.uni-heidelberg.de",
        ),
        (name: "Aaron Boheim", email: "aaron.boheim@stud.uni-heidelberg.de"),
    ),
    tutor: "Natalia Sycheva",
    date: "31.08.2025",
)

= Introduction
== AI Usage
AI used only in the introduction part the help with formulation.

== Goal

The aim of this experiment is to investigate the rotational motion of a rotary
pendulum. In particular, the directing torque $D$ is determined using two
independent methods. Furthermore, the moment of inertia of an irregularly shaped
body is determined about different parallel axes, and the experimental results
are compared with Steiner's theorem.

== Physical Foundation

Rotational motion is described by equations analogous to those of linear motion.
For a harmonic spring pendulum, the restoring force is proportional to the
displacement,

$ F = -k x $

which leads to the oscillation period

$ T = 2 pi sqrt(m/k). $

For a rotary pendulum, the analogous quantity to the displacement is the angular
displacement $phi$, and the restoring force is replaced by a directing torque.
For small angular displacements, we assume the directing torque to be

$ M = -D phi, $

where $D$ is the directing torque of the spring system. The equation of motion
of a rotary pendulum with moment of inertia $J$ is consequently

$ J phi'' + D phi = 0, $

which describes harmonic oscillations with the period

$ T = 2 pi sqrt(J / D). $

This relation allows the directing torque to be determined from the oscillation
period when the moment of inertia is known.

The moment of inertia depends on both the mass distribution of a body and the
chosen axis of rotation. For a homogeneous disc with mass $m_s$ and radius
$r_s$, it is

$ J_s = 1/2 m_s r_s^2. $

For an irregularly shaped body, the moment of inertia can be determined
experimentally from its oscillation period. To investigate the dependence on the
position of the rotation axis, Steiner's theorem is used. It states that the
moment of inertia about an axis parallel to one through the centre of mass and
displaced by a distance $a$ is

$ J = J_u + M a^2, $

where $J_u$ is the moment of inertia about the axis through the centre of mass
and $M$ is the mass of the body.

== Measurement Setup and Procedure

The measurements are carried out using a rotary pendulum with a vertical
rotation axis, a rotary fork and turntable. The setup also contains an aluminium
disc with a cord groove and angular graduation, a brass disc, an irregularly
shaped brass disc, a weight plate with pull cord and several weights. A scale,
stopwatch, calipers, and a balancing blade are used for the measurements. A
sketch of the complete setup is shown in the following section.

The directing torque is first determined statically. The aluminium disc is
mounted on the rotation axis and a tangential force is applied to it by means of
the cord and suspended weights. The resulting deflection angle is recorded for
several applied torques. The directing torque is then obtained from the relation
between torque and angular deflection.

As a second method, the directing torque is determined from the oscillation
period. The period of the turntable is measured first without an additional disc
and then with a brass disc of known mass and radius mounted with its centre on
the rotation axis. The period is three times over 20 oscillations.

For the irregularly shaped brass plate, its centre of gravity is first found
using the balancing blade. The plate is positioned in two approximately
perpendicular equilibrium orientations, and the corresponding lines along the
blade are marked; their intersection gives the centre of gravity. The plate is
then mounted so that this point lies on the rotation axis, and its moment of
inertia is determined by measuring three times 20 oscillations. Finally, the
plate is mounted with the rotation axis at five different distances from the
centre of gravity and we measure three times 20 oscillations in each position.

= Measurement Protocol

#figure(
    image("Messwerte_Signed.png"),
    caption: [Protocol of the experiment],
)

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
the Pendulum with and without a disk with known Moment of Inertia.

The disk has a mass of $qty("542+-1", "g")$ and a radius of
$qty("525.5+-0.25", "mm")$. The uncertainties are from the scale and from the
caliper.

Using the Formula for the Moment of Inertia of a Disk, we get
$ J_S = 1/2 m_s r_s^2 = qty("0.000748+-0.000007", "kg m^2") $

We used python package `uncertainties`, which calculates the Error analytically,
by hand we have to calculate the total derivative of $J_s$:

$ dif J_s = 1 / 2 r_s^2 dif m + m_s r_s dif r_s $
Using the Laws of error propagation, we get:
$
    Delta J_s = sqrt((1/2 r_s^2 Delta m)^2 + (m_s r_s Delta r_s)^2) approx 7.3 dot 10^(-6) "kg" "m"^2
$

We measured the time of 20 periods using a stopwatch (device error negligble).
We estimated the error due to our reaction time to be about $qty("200", "ms")$.

We added this (according to the rules of error propagation) to the average error
of the mean value $S_M = S_E / sqrt(N)$ (determined from the 3 measurements):

$ Delta T = sqrt((qty(200, "ms"))^2 + S_M^2) $

For our measurements, we got a Period of

$ "Without Disk:" T_1 = qty("1.222 +- 0.010", "s") $
$ "With Disk:" T_2 = qty("1.670+-0.010", "s") $

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

#rect($ D_2 = qty("0.0228+-0.0008", "N m /rad") $)

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


#rect[$
        "Directing Torque determined statically" D_1 = qty("0.02320+-0.00017", "N m / rad")
    $

    $
        "Directing Torque determined with the oscillation " D_2 = qty("0.0228+-0.0008", "N m /rad")
    $
]

#rect[$
    "Moment of Intertia of the unknown Shape: " J_u = qty("0.002283+-0.000035", "kg m^2")
$]



= Discussion

== Directing Torque

We determined the directing torque of the spring with two different methods. The
standardized Difference is
$ beta_D = (D_1 - D_2) / sqrt(Delta D_1^2 + Delta D_2^2) approx 0.49 $
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

