from uncertainties import ufloat, unp 
import numpy as np

# Aufgabe 1
# Gewicht zu Winkel
# Gewichte in g
Gewichte = np.array([10,60,110,160,210,260])

# Winkel in Grad
# (Unsicherheit 1 Grad)
Winkel = [ufloat(0,1),ufloat(60,1),ufloat(120,1),ufloat(179,3),ufloat(239,3),ufloat(308,3)]



# Aufgabe 2
# Reaktionszeit 0.2
# 20 Schwingungen
Zeit = [
    [ufloat(24.45,0.2),ufloat(24.46,0.2),ufloat(24.4,0.2)], # Nur der Tisch 
    [ufloat(33.40,0.2),ufloat(33.42,0.2),ufloat(34.39,0.2)]

Durchmesser_Scheibe = ufloat(0.1051,0.0002) # in m
Gewicht_Scheibe = ufloat(542,1) # in g # TODO unsicherheit??

J_Scheibe = 1/2 * (Gewicht_Scheibe / 1000) * Durchmesser_Scheibe ** 2

# Aufgabe 4

# 20 Schwingungen, unbekanntes Objekt
Zeit = [
        [ufloat(46.43,0.2),ufloat(46.34, 0.2),ufloat(46.36,0.2)]
]

# Aufgabe 5

# Satz von Steiner

Masse_komisches_Ding = ufloat(665,1) # in g
# Distanz zum Mittelpunkt in mm

Dist = [5,10,20,30,40]

# 20 Schwingungen
Zeiten_komisches_Ding = [
        [ufloat(46.42,0.2),ufloat(46.42,0.2),ufloat(46.42,0.2)],
        [ufloat(46.56,0.2),ufloat(46.58,0.2),ufloat(46.58,0.2)],
        [ufloat(47.73,0.2),ufloat(47.72,0.2),ufloat(47.78,0.2)],
        [ufloat(49.75,0.2),ufloat(49.75,0.2),ufloat(49.64,0.2)],
        [ufloat(52.54,0.2),ufloat(52.34,0.2),ufloat(53.36,0.2)]
]

# Fehlerquellen
# Scheibe isch schief + Dummheit
