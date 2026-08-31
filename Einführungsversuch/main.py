from uncertainties import ufloat, unumpy
import matplotlib.pyplot as plt
import numpy as np
import scipy

Period_weights= np.array([60,110, 160, 210, 260])
T_measurements = np.array([
    [2.72, 2.81, 2.81],
    [3.7, 3.72, 3.70],
    [4.42, 4.46, 4.48],
    [5.02, 5.04, 5.01],
    [5.51, 5.62, 5.58]
])

T_period_measurements = T_measurements / 3 

T_period = unumpy.uarray([np.average(T_period_measurements[i]) for i in range(5)], [np.std(T_period_measurements[i],ddof=1) / np.sqrt(3) for i in range(5)])

T_squared = T_period** 2

## Fenjas werte
T_squared = np.array([0.752, 1.416, 1.96, 2.57, 3.12])
T_squared_sigma = np.array([0.018, 0.015, 0.03, 0.04, 0.07])


print(unumpy.nominal_values(T_squared))

def linearFunction(x, intercept, slope):
    return intercept + slope * x

#a_fit, cov = scipy.optimize.curve_fit(linearFunction, Period_weights, unumpy.nominal_values(T_squared),sigma=unumpy.std_devs(T_squared),absolute_sigma=True)
a_fit, cov = scipy.optimize.curve_fit(linearFunction, Period_weights, T_squared, sigma=T_squared_sigma ,absolute_sigma=True)

inter = a_fit[0]
slope =  a_fit[1]
d_inter = np.sqrt(cov[0][0])
d_slope = np.sqrt(cov[1][1])

D = 4 * np.pi ** 2 / (ufloat(slope, d_slope) * 1000)
print(f"D: {D} (slope: {slope})")

def plot_T_fit():

    # Create a graph showing the data.
    plt.errorbar(Period_weights,unumpy.nominal_values(T_squared),yerr=unumpy.std_devs(T_squared),fmt='r.',label='Data')

    # Compute a best fit line from the fit intercept and slope.
    yfit = inter + slope*Period_weights

    # Create a graph of the fit to the data. We just use the ordinary plot
    # command for this.
    plt.plot(Period_weights,yfit,label='Fit')

    max_slope = slope + d_slope

    yfit_max = inter + d_inter + max_slope*Period_weights
    plt.plot(Period_weights,yfit_max,label="Error")

    yfit_max = inter - d_inter + (slope -d_slope)*Period_weights
    plt.plot(Period_weights,yfit_max,label="Error 2")
    # Display a legend, label the x and y axes and title the graph.
    plt.legend()
    plt.xlabel('m in g')
    plt.ylabel('T^2')

    # Save the figure to a file
    plt.savefig('T_squred_weights.png',dpi=300)

    # Show the graph in a new window on the users screen.
    plt.show()

plot_T_fit()

Auslenkung_weights = np.array([0, 50, 100, 150,200, 250])
#Auslenkung = np.array([190,356,521,685, 849,1008])
Auslenkung = [119.5, 278, 435, 591, 745, 893]

a_fit, cov = scipy.optimize.curve_fit(linearFunction, Auslenkung_weights, Auslenkung,sigma=[2] * 6, absolute_sigma=True)

inter = a_fit[0]
slope =  a_fit[1]
d_inter = np.sqrt(cov[0][0])
d_slope = np.sqrt(cov[1][1])

print(slope, d_slope)
print(inter, d_inter)

a = ufloat(slope,d_slope)

print(f"a : {a}, D: {D}")
g = a * D

print(f"g: {g}")
