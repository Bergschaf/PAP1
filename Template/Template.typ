
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
    #text(weight: "bold", size: 16pt)[Physikalisches Anfängerpraktikum der Universität Heidelberg] \
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
    ]
  )

  v(3em)

  // Inhaltsverzeichnis
  outline(title: "Inhaltsverzeichnis", depth: 2)
  pagebreak()

  body
}

#set math.equation(numbering: "(1)")

// ==========================================
// HIER BEGINNT DEIN DOKUMENT
// ==========================================
#show: project.with(
  title: "Titel des Versuchs",
  versuch_nr: "XX",
  authors: (
    (name: "Aaron Boheim", email: "aaron.boheim@stud.uni-heidelberg.de"),
    (name: "Christian Krause", email: "christian.krause@stud.uni-heidelberg.de"),
  ),
  tutor: "Name des Tutors",
  date: "27.08.2025",
)

= Einleitung
== Motivation und Ziel des Versuchs
Hier kurz die Motivation beschreiben. Was wird gemessen und warum? 

== Physikalische Grundlagen
Kurze, knappe Darstellung der Physik (ca. 1-2 Seiten). Die theoretischen Grundlagen, Begriffe und Gesetze, die zum Verständnis erforderlich sind, sollen hier formuliert werden.
Alle Abkürzungen, die in den Formeln vorkommen, müssen erklärt werden. Formeln sind fortlaufend zu nummerieren:

== Skizze der Versuchsanordnung / Schaltpläne
Hier eine Skizze der Apparatur oder den Schaltplan (bei elektrischen Schaltungen) einfügen und kurz erklären, falls das Messverfahren nicht völlig selbstverständlich ist.

= Versuchsprotokoll und Messdaten
Hier sind die originalen, vom Tutor/Assistenten unterschriebenen Messdaten als Foto oder Scan einzufügen.


= Auswertung
Hier beginnt die Bearbeitung der Auswertungsaufgaben aus dem Skript. Die Kapitel müssen mit *aussagekräftigen Überschriften* versehen werden (nur "Aufgabe 1" reicht laut Mängelkatalog nicht!).

= Präsentation der Endergebnisse
Die Endergebnisse müssen mit der entsprechenden Unsicherheit angegeben und *gesondert hervorgehoben* werden. Achte auf die korrekte, sinnige Angabe von Nachkommastellen (passend zum Fehler)!

= Zusammenfassung und Diskussion
Hier reicht es nicht aus, den Versuch nur zusammenzufassen. 
- *Interpretation:* Was bedeuten die Ergebnisse physikalisch?
- *Vergleich:* Die wesentlichen Resultate müssen herausgestellt und mit den Erwartungen bzw. Literaturwerten verglichen werden.
- *Diskussion:* Abweichungen quantitativ diskutieren. Gab es systematische Fehler im Aufbau? Was hätte man bei der Durchführung besser machen können?
