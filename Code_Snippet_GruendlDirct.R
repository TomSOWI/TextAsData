### TaD Gruppenaufgabe 03.07 Hands on
### Anwendung von Gründl

# Pakete installieren -------------------------------------------------

#devtools für das direkte laden aus github
install.packages("devtools")

#die 3 nötigen Pakte von Gründls Dicitonary laden
devtools::install_github("jogrue/regexhelpeR")
devtools::install_github("jogrue/multidictR")
devtools::install_github("jogrue/popdictR")

#alle pakete in der library aktivieren (auf einmal)
needed.packages <- c("quanteda", "tidyverse", "devtools", "regexhelpeR", "multidictR", "popdictR")
invisible(lapply(needed.packages, library, character.only = TRUE))
#alternativ natürlich mit "libary(quanteda)", etc. alle nacheinander laden. 


# Daten einlesen ---------------------------------------------------------------

getwd()
speeches <- readRDS("opendiscourse_term20.rds") 
#hier den korrekten Dateipfad angeben

# Daten bearbeiten -------------------------------------------------------------

#falls nötig filtern, z.B nach Datum oder ID, etc., das sieht dann so aus:
#speeches <- speeches %>%
#filter(id >= 1071730, )

#Corpus erstellen
raw_corpus <- corpus(speeches, text_field = 6) 

#Paket auschecken, wie funktioniert das?
??popdictR

# Dictionary anwenden ----------------------------------------------------------

results <- run_popdict(raw_corpus, return_value = "count_at_level")

#Datensatz aus den Ergebnissen erstellen
results_dataframe <- convert(results1, to = "data.frame")

#Zusammenfassung mit tidyverse, gruppiert nach Partei
summary <- results_dataframe %>%
  group_by(full_name) %>%
  summarize(sentences   = sum(n_sentences),
            gruendl     = sum(dict_gruendl_2020) / sentences * 100) %>%
  ungroup

#In der Konsole anschauen
summary

#hier könnte noch ein Histogram/bar chart hin...
#ist nicht fertig

#histogram <- results_dataframe %>%
#group_by(full_name) %>%
#summarize(
# sentences = sum(n_sentences),
#gruendl = sum(dict_gruendl_2020) / sentences * 100
# ) ...

