
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
    tutor: "Shogo Nagai",
    date: "1.09.2026",
)

#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")


#set page(numbering: "1")

= Introduction
== AI Usage

AI was used only in the Introduction to help with formulation.

== Goal

The goal of this experiment is to investigate the damping of a rotary pendulum
using different measurement methods. The damping constant $delta$ is determined
from the decrease of the amplitude of a free oscillation, the half-width of a
resonance curve, and the resonance amplification. The results are then compared.

== Foundations

The experiment uses a rotary pendulum (Pohl's wheel). For a damped free
oscillation, the angular displacement is

$ phi(t) = phi_0 e^(-delta t) sin(omega_f t) , $

where $delta$ is the damping constant and $omega_f$ is the angular frequency of
the damped oscillation. The amplitude therefore decreases exponentially:

$ a(t) = a_0 e^(-delta t). $

The damping constant can therefore be determined from the half-life of the
amplitude, defined by $a(t_(1/2)) = a_0/2$:

$ delta = ln(2) / t_(1/2). $<delta_rechnung>

The damped and undamped angular frequencies are related by

$ omega_f = sqrt(omega_0^2 - delta^2). $

When the pendulum is driven periodically with angular frequency $omega$, a
forced oscillation is produced. After the transient motion has decayed, the
stationary amplitude is

$ b(omega) = (A omega_0^2) / sqrt((omega_0^2 - omega^2)^2 + (2delta omega)^2), $

where $A$ is the amplitude of the excitation. The amplitude reaches its maximum
at the resonance frequency

$ omega' = sqrt(omega_0^2 - 2delta^2). $

For weak damping, $omega' approx omega_0$. The damping can also be obtained from
the half-width $H$ of the resonance curve:

$ H = omega_2 - omega_1 = 2delta, $<delta_H>

where $omega_1$ and $omega_2$ are the frequencies at which the squared amplitude
has fallen to half its maximum value. Another measure of damping is given by the
resonance amplification,

$ b(omega') / b(omega -> 0) = omega_0 / (2delta). $

== Measurement

The experiment is carried out using a rotary pendulum with an eddy-current brake
for controlled damping. A stepper motor with an eccentric provides the periodic
excitation. Its controller and power supply drive the motor, while a function
generator provides the TTL square-wave control signal. A separate power supply
is used for the eddy-current brake. The setup is shown in the sketch below.

First, the undamped oscillation period $T_0$ is measured by timing three times
20 oscillations.

The damping is then switched on for two different brake currents. For each
current, the time it takes for the amplitude to decay to $5%$ of the original
amplitude is recorded and is used to determine how long to perform the following
experiment:

The amplitude of the freely oscillating pendulum is recorded at successive
reversal points and plotted on a logarithmic scale.

For the forced oscillation, the stationary amplitude is measured for different
excitation frequencies between 0.1 and 1Hz and for both damping values. The
resonance curve is used to determine the resonance frequency, half-width, and
resonance amplification. The phase difference between the exciter and the
pendulum is also observed at low frequency, near resonance, and at high
frequency.

= Protocol

#figure(
    stack(
        box(
            image("13.pdf", page: 2),
            clip: true,
            inset: (top: -5.6in, bottom: -0.2in),
        ),
        image("13.pdf", page: 3),
    ),
    caption: [Protocol],
)

== Sketch

#figure(
    image("Skizze.jpeg"),
    caption: "Sketch of the Setup",
)

= Evaluation

== Determining the osciallation period

We measured 3 times 20 oszillations using a stopwatch. We assume the error due
to the reaction time to be abount $qty(200, "ms")$ (we neglect the much smaller
internal error of the Stopwatch)

As the first step, we divided all measured times by $20$ and calculated the
average error of a measurement $S_E$.

We added the error of the mean value $S_M = S_E / sqrt(3)$ to the reaction time
according to the laws of error propagation:

$ Delta T = sqrt(S_M^2 + (qty("200", "ms")/20)^2) approx 0.010 $

This results in a Period of
#rect[
    $ T = qty("2.319+-0.010", "s") $
]

In practice, we used the python package `uncertainties` to keep track of the
errors, but I am going to write out the important steps here as well.

== Determining the damping constant with the amplitude decrease of the free ociallation

We assumed our error when reading out the amplitude to be
$Delta a = qty("1", "Degree")$, because the Resolution of our Scale was $2°$.

@plot1 shows the amplitude as function of the number of oscillations. To
determine the damping constant, we performed the following steps:
+ matching regression lines through the values
+ determining the half-life of the amplitude $t_(1/2)$
We know from @delta_rechnung, that we can compute $delta$ using
$ delta = ln(2)/T_(1/2) $<delta>

where $T_(1/2)$ is the half-life of the amplitude in seconds. (We are going to
denote the half-life of the amplitude measured in the number of Periods as
$t_(1/2)$)

To estimate the error $Delta delta$, I estimated the orange lines to be a lower
and upper bound on the $1 sigma$-Intervall of the slope of the regression lines.
I determined the half-life of these error-lines as well, which gave me a upper
and lower bound on the $1sigma$-Intervall of $t_(1/2)$. I then used the bound
which was the farthest from the value of $t_(1/2)$ as an upper bound on the
error of $t_(1/2)$, which gave me the following two values for $t_(1/2)$

$ "40mA Damping:" t_(1/2) = num("3.4+-0.5") "Periods" $
$ "55mA Damping:" t_(1_2) = num("1.95+-0.2") "Periods" $
We have to multply by the period $T$ that we determined earlier:

$ "40mA Damping:" T_(1/2) = t_(1/2) dot T = qty("7.4+-1.1", "s") $
$ "55mA Damping:" T_(1_2) = t_(1/2) dot T = qty("4.2+-0.4", "s") $


Using @delta, we get

#rect[
    $ "40mA Damping:" delta = qty("0.094+-0.014", "/s") $
    $ "55mA Damping:" delta = qty("0.163+-0.017", "/s") $

]


Error Propagation by Hand:

$ dif T_(1/2) = t_(1/2) dif T + T dif t_(1/2) $
$ Delta T_(1/2) = sqrt((t_(1/2) Delta T)^2 + (T Delta t_(1/2))^2) $


$ dif delta = - ln(2)/(T_(1/2)^2) dif T_(1/2) $
$
    Delta delta = abs(-ln(2)/(T_(1/2)^2) Delta T_(1/2)) = ln(2)/(T_(1/2)^2) dif T_(1/2)
$



#figure(
    image("Christian/V13_plots.pdf", page: 3),
    caption: [Amplitude as a function of the number of oscillations in a
        logarithmic plot],
)<plot1>


== Determining the damping constant with a forced oscillation

In @plot2 I plotted the amplitude as a function of the excitation frequency.

We assumed an error of $Delta a = 1°$ again when reading out the amplitude. We
observed the frequency of the frequency generator varying in a range of about
$Delta f_g = 2 "Hz"$. The error of the scale of the device ($0.1"Hz"$) is
neglegible compared to this.

We also chose to ignore the error of the frequency generator $Delta f_g$ varying
in a $2 "Hz"$ range, because it is neglegible compared to the error $Delta a$ we
had when measuring the amplitude.

=== Determning the resonance frequency
We read out the resonance frequency from @plot2 assuming that the curve is
mostly symmetric in the upper part:

$ "40mA Damping:" f_g = qty("1820+-20", "Hz") $
$ "55mA Damping:" f_g = qty("1830+-20", "Hz") $

We get the real resonance frequency of the Pendulum by dividing by $4000$ and
multiplying by $2 pi$:

$ "40mA Damping:" omega' = qty("2.859+-0.032", "Hz") $
$ "55mA Damping:" omega' = qty("2.875+-0.032", "Hz") $

One important parameter of the curve is the half-width $H$, which speicifies the
difference of the two Frequencies $w_2 - w_1$ where the Amplitude $b(omega)$
reaches $b(w')/sqrt(2)$ (with the resonance frequency $omega'$).

$ "40mA Damping:" H_g = qty("120+-10", "Hz") $
$ "55mA Damping:" H_g = qty("200+-10", "Hz") $

We assumed the error $Delta H$ to be $Delta H = 10 "Hz"$ because of the
resolution of the graph paper (which is $20 "Hz"$).

$H_g$ is still in terms of the generator frequency, we have to divide by $4000$
to get $H$ in terms of the excitation frequency:

$ "40mA Damping:" H = qty("0.030+-0.0025", "Hz") $
$ "55mA Damping:" H = qty("0.050+-0.0025", "Hz") $

Now we can use @delta_H to calculate $delta$:

#rect[
    $ "40mA Damping:" delta = qty("0.094+-0.008", "Hz") $
    $ "55mA Damping:" delta = qty("0.157+-0.008", "Hz") $]


#figure(
    rotate(image("Christian/V13_plots.pdf", page: 2), -90deg),
    caption: [Amplitude as a function of the frequency of the motor],
)<plot2>

== Calculation using resonance amplification

The resonance amplification is given by the ratio

$ b_max / b_0 = omega_0 / (2 delta) $
with $b_max$ being the maximum amplitude and $b_0$ being the amplitude as the
frequency tends to zero.

Using our measurements for $b_max$, $b_0$ and
$omega_0 = (2 pi)/T = qty("2.884+-0.015", "Hz")$, we can calculate $delta$:

$ delta = (omega_0 b_0)/(2 b_max) $

#align(center)[
    #table(
        columns: 4,
        [], [$b_max$ in °], [$b_zero$ in °], [$delta$ in $s^(-1)$],
        "40mA Damping", num("42.5+-1.0"), num("2.5+-1.0"), num("0.085+-0.034"),

        "50mA Damping", num("22.0+-1.0"), num("2.5+-1.0"), num("0.16+-0.07"),
    )]

Error Propagation by Hand:

$
    dif delta = b_0 / (2 b_max) dif w_0 + omega_0 / (2 b_max) dif b_0 - (2 w_0 b_0)/(2 b_max)^2 dif b_max
$

$
    Delta delta = sqrt((b_0 / (2 b_max) Delta w_0)^2 + (omega_0 / (2 b_max) Delta b_0)^2 + ((2 w_0 b_0)/(2 b_max)^2 Delta b_max)^2)
$



== Phase shift
For very small frequencies, we observed no phase difference between the exciter
and the pendulum. At the resonance frequency, there was a phase shit of $pi/2$
and at very high frequencies, there was a phase difference of $pi$.

= Results


#rect[
    $ T = qty("2.319+-0.010", "s") $
]

#figure(
    caption: [Our values of $delta$ (in Hz)],
    table(
        columns: 3,
        [Method], [40 mA damping], [55 mA Damping],
        [Amplitude decrease], num("0.094+-0.014"), num("0.163+-0.017"),
        [Half-Width], num("0.094+-0.008"), num("0.157+-0.008"),
        [Resonance Amplification], num("0.085+-0.034"), num("0.16+-0.07"),
    ),
)

#figure(
    caption: [Resonance Frequency],
    table(
        columns: 3,
        [], [Frequency], [Standardized mean difference to $omega_0$],
        [Natural Frequency $omega_0$], qty("2.884+-0.015", "Hz"), [0],
        [40mA Dampening $omega'$], qty("2.859+-0.032", "Hz"), num("0.74"),
        [55mA Dampening $omega'$], qty("2.875+-0.032", "Hz"), num("0.27"),
    ),
)<table_res>
= Discussion

To check if the different measurements for $delta$ are within the error margin
of each other, i computed the standardized mean difference $beta$ between all
value pairs:

$ beta = abs(delta_1 - delta_2)/sqrt(sigma_1^2 + sigma_2^2) $
#figure(
    table(
        columns: 4,
        [40mA Damping],
        [Amplitude decrease],
        [Half-Width],
        [Resonance Amplification],

        [Amplitude decrease], [0.0], [0.0], [0.24],
        [Half-Width], [0.0], [0.0], [0.26],
        [Resonance Amplification], [0.24], [0.26], [0.0],
    ),
    caption: [$beta$ for 40mA Damping],
)

#figure(
    table(
        columns: 4,
        [55mA Damping],
        [Amplitude decrease],
        [Half-Width],
        [Resonance Amplification],

        [Amplitude decrease], [0.0], [0.32], [0.04],
        [Half-Width], [0.32], [0.0], [0.04],
        [Resonance Amplification], [0.04], [0.04], [0.0],
    ),
    caption: [$beta$ for 55mA Damping],
)

We can see, that all values are a lot smaller than 1, which means that all
values lie well inside $1 sigma$ of each other.

== Period
We assume that the Period is constant during the 20 oscillations, which ignores
effects of friction and the decay of the amplitude. Taking these terms into
account could make the measurement more precise alongside with a much longer
measurement.

== Amplitude decrease

In @plot1, we can observe that the amplitude of the last few oscillations
doesn't match the regression line very well.

A possible cause for this could be, that there were other friction factors, that
were not proportional to $dot(phi)$. One example might be the turbulent air
friction which is proportional to $dot(phi)^2$. For the very small velcities,
there is also nonlinear friction effects at the transition from sliding friction
to static friction (stick-slip). This could be the case inside the bearing of
the Pendulum when it is swinging at very small amplitudes where it spends more
time at very slow velocities.

This method would be a lot more accurate for Experiments that run for a lot more
Periods (like the Pendulum in Experiment 14).


== Half Width
Estimating the error of the Half-width that we measured graphically proved to be
quite difficult. Theoretically, we would have to take into account the error of
the resonanc-curve that we fitted to our measurement, but this is difficult to
estimate, especially on paper. I approximated the curve by just connecting our
measurement with straight lines. This is reasonably accurate, because we took
many measurements in the area aorund the peak, where the slope changes a lot.

This Method could be even more accurate with more measurements around the Peak
and the half-width. Using an algorithm to fit a curve to the points could also
help with the accuracy and be useful to get a proper estimate of the error.

== Resonance Amplification
The error of the resonance amplification is very big compared to the other
methods. The main reason for this, is that we had an error of $Delta a = 1°$ for
measuring the amplitude, which is very big compared to the small amplitudes
($b_0 = 2.5°$).

Using a motor with a bigger crank, could make this Method a lot more accurate by
increasing the amlitude for very small excitation frequencies. This could
runinto the issue of the Spring not behaving linearly anymore for very big
amplitudes at the resoncance frequency.

== Resonance Frequency

We can't observe anything useful about the resonance frequencies for the
different amounts of damping, because we can't determine them precisely enough
with this experiment. As you can see in @table_res, they are all inside of less
than $1 sigma$ of the natural Frequency.

To get better results, the Period would have to be determined more precisely to
compute the natural frequency with less error. A higher densitiy of amplitude
measurements around the resonance frequency would also increase the precision of
this experiment more.

