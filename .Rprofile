# # Load libraries
# library(tidyverse)
# library(h2o)
# 
# # Load data
# kgwr <- read_delim("https://data.bl.ch/api/explore/v2.1/catalog/datasets/12160/exports/csv?lang=de&timezone=Europe%2FParis&use_labels=true&delimiter=%3B", delim = ";")
# 
# 
# # Prepare data
# kgwr_residential <- kgwr |>
#   filter(gebaeudekategorie_bezeichnung == "Gebäude mit ausschliesslicher Wohnnutzung",
#          gebaeudestatus_bezeichnung == "Bestehend") |>
#   mutate(energie_waermequelle_heizung_primaer_gruppiert = case_when(
#     energie_waermequelle_heizung_primaer_bezeichnung %in% c("Elektrizität") ~ "Electricity",
#     energie_waermequelle_heizung_primaer_bezeichnung %in% c("Erdregister", "Erdwärme (generisch)", "Erdwärmesonde", "Wasser", "Luft") ~ "Geothermal",
#     energie_waermequelle_heizung_primaer_bezeichnung == "Fernwärme (generisch)" ~ "District Heating",
#     energie_waermequelle_heizung_primaer_bezeichnung == "Gas" ~ "Gas",
#     energie_waermequelle_heizung_primaer_bezeichnung == "Heizöl" ~ "Oil",
#     energie_waermequelle_heizung_primaer_bezeichnung %in% c("Holz (Pellets)", "Holz (Schnitzel)", "Holz (Stückholz)", "Holz (generisch)") ~ "Wood",
#     energie_waermequelle_heizung_primaer_bezeichnung == "Sonne (thermisch)" ~ "Solar",
#     energie_waermequelle_heizung_primaer_bezeichnung %in% c("Unbestimmt", "Keine") ~ "Undefined",
#     energie_waermequelle_heizung_primaer_bezeichnung == "Wasser (Grundwasser, Oberflächenwasser, Abwasser)" ~ "Water",
#     energie_waermequelle_heizung_primaer_bezeichnung == "Andere" ~ "Other",
#     TRUE ~ "Other"
#     )
#   )

