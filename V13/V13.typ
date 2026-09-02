
#import "@preview/unify:0.8.1": num, numrange, qty, qtyrange
#set math.equation(numbering: "(1)")


#set page(numbering: "1")

= Introduction

== Goal

- Measuring the dampening with various methods

== Foundations

= Protocol


== Sketch

#figure(
    image("Skizze.jpeg"),
    caption: "Sketch of the Setup",
)

= Evaluation

== Determining the osciallation period

We measured 3 times 20 oszillations using a stopwatch. We assome the error due
to the reaction time to be abount $qty(200, "ms")$ (-> Stopwatch error is much
smaller -> neglegible).

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

== Determining the dampening constant with the amplitude decrease of the free ociallation

We assumed our error to be $qty("1", "Degree")$. @plot1 shows the amplitude as
function of the number of oscillations. To determine the dampening constant, we
performed the following steps:
+ matching regression lines through the values
+ determining the half-life of the amplitude $t_(1/2)$
We know from the introduction (TODO reference), that we can compute $delta$
using (TODO Reference)
$ delta = ln(2)/t_(1/2) $<delta>

To estimate the error $Delta delta$, I estimated the orange lines to be a lower
and upper bound on the $1 sigma$-Intervall of the slope of the regression lines.
I determined the half-life of these error-lines as well, which gave me a upper
and lower bound on the $1sigma$-Intervall of $t_(1/2)$. I then used the bound
which was the farthest from the value of $t_(1/2)$ as an upper bound on the
error of $t_(1/2)$, which gave me the following two values for $t_(1/2)$

$ "40mA Dampening:" t_(1/2) = qty("3.4+-0.5", "s") $
$ "55mA Dampening:" t_(1_2) = qty("1.95+-0.2", "s") $

Using @delta, we get

#rect[
    $ "40mA Dampening:" delta = qty("0.094+-0.014", "/s") $
    $ "55mA Dampening:" delta = qty("0.163+-0.017", "/s") $

]

Error Propagation by Hand: TODO

#figure(
    image("Christian/V13_plots.pdf", page: 3),
    caption: [Amplitude as a function of the number of oscillations in a
        logarithmic plot],
)<plot1>


== Determining the dampening constant with a forced oscillation

In @plot2 I plotted the amplitude as a function of the excitation frequency.

One important parameter of the curve is the half-width $H$, which speicifies the
difference of the two Frequencies $w_2 - w_1$ where the Amplitude $b(omega)$
reaches $b(w')/sqrt(2)$ (with the resonance frequency $omega'$). TODO genauer,
hier ists ja noch die eneratorfrequenz

$ "40mA Dampening:" H = qty("120+-10", "Hz") $
$ "55mA Dampening:" H = qty("200+-10", "Hz") $

Estimating the error of this Half-width proved to be quite difficult.
Theoretically, we would have to take into account the error of the
resonanc-curve that we fitted to our measurement, but this is difficult to
estimate, especially on paper. I approximated the curve by just connecting our
measurement with straight lines. This is reasonably accurate, because we took
many measurements in the area aorund the peak, where the slope changes a lot.

The error of $10 "Hz"$ comes from the resolution of the graph paper.

After dividing by $4000$ to get the excitation frequency, we can then use
Formula (TODO Reference) to calculate delta


#rect[
    $ "40mA Dampening:" delta = qty("0.094+-0.008", "Hz") $
    $ "55mA Dampening:" delta = qty("0.157+-0.008", "Hz") $]


#figure(
    rotate(image("Christian/V13_plots.pdf", page: 2), -90deg),
    caption: [Amplitude as a function of the frequency of the motor],
)<plot2>
TODO als funktion von generatorfrquenc plotten wär besser

== Calculation using resonance amplification

The resonance amplification is given by the ratio

$ b_max / b_0 = omega_0 / (2 delta) $
with $b_max$ being the maximum amplitude and $b_0$ being the amplitude as the
frequency tends to zero.

Using our measurements for $b_max$, $b_0$ and $omega_0$, we can calculate
$delta$ this way:

#align(center)[
    #table(
        columns: 4,
        [], [$b_max$ in °], [$b_zero$ in °], [$delta$ in $s^(-1)$],
        "40mA Dampening",
        num("42.5+-1.0"),
        num("2.5+-1.0"),
        num("0.085+-0.034"),

        "50mA Dampening", num("22.0+-1.0"), num("2.5+-1.0"), num("0.16+-0.07"),
    )]

== Phase shift
For very small frequencies, we observed no phase difference between the exciter
andthe pendulum. At the resonance frequency, there was a phase shit of $pi/2$
and at very high frequencies, there was a phase difference of $pi$.

= Results:

#rect[
    $ T = qty("2.319+-0.010", "s") $
]

#figure(
    caption: [Our values of $delta$ (in Hz)],
    table(
        columns: 3,
        [Method], [40 mA dampening], [55 mA Dampening],
        [Amplitude decrease], num("0.094+-0.014"), num("0.163+-0.017"),
        [Half-Width], num("0.094+-0.008"), num("0.157+-0.008"),
        [Resonance Amplification], num("0.085+-0.034"), num("0.16+-0.07"),
    ),
)

= Discussion

To check if the different measurements for $delta$ are within the error margin
of each other, i computed the standardized mean difference $beta$ between all
value pairs:

$ beta = (delta_1 - delta_2)/sqrt(sigma_1^2 + sigma_2^2) $
#figure(
    table(
        columns: 4,
        [40mA Dampening],
        [Amplitude decrease],
        [Half-Width],
        [Resonance Amplification],

        [Amplitude decrease], [0.0], [0.0], [0.24],
        [Half-Width], [0.0], [0.0], [0.26],
        [Resonance Amplification], [-0.24], [-0.26], [0.0],
    ),
    caption: [$beta$ for 40mA Dampening],
)

#figure(
    table(
        columns: 4,
        [55mA Dampening],
        [Amplitude decrease],
        [Half-Width],
        [Resonance Amplification],

        [Amplitude decrease], [0.0], [0.32], [0.04],
        [Half-Width], [-0.32], [0.0], [-0.04],
        [Resonance Amplification], [-0.04], [0.04], [0.0],
    ),
    caption: [$beta$ for 55mA Dampening],
)

We can see, that all values are a lot smaller than 1, which means that all
values lie well inside the error margin of each other.

== Amplitude decrease

In @plot1, we can observe that the amplitude of the last few oscillations
doesn't match the regression line very well.

A possible cause for this could be, that there were other friction factors, that
were not proportional to $dot(phi)$ (for example static friction), which got
bigger at smaller velocities and amplitudes.

== Task 5

- Error analysis difficult (especially on paper because we can't fit different
curves) (Error of frequency generator vlt)

- Passt prima mit Fehler



