# Chargement des bibliothèques
library(igraph)
library(data.table)

# Chargement des données
metro_matrix <- read.csv("C:\\Users\\hp\\OneDrive\\Bureau\\metro_distance_matrix_updated.csv", header = TRUE)

# Préparation des données
station_names <- metro_matrix[, 1]  # Extraire les noms des stations
metro_matrix <- metro_matrix[, -1]  # Supprimer la colonne des noms des stations
metro_matrix <- as.matrix(metro_matrix)  # Convertir en matrice

# Identifier les connexions valides (poids ≠ exp(10))
metro_edges <- which(metro_matrix != exp(10), arr.ind = TRUE)
weights <- metro_matrix[metro_edges]

# Créer un tableau d'arêtes avec les poids
edge_list <- data.frame(
  from = station_names[metro_edges[, 1]],
  to = station_names[metro_edges[, 2]],
  weight = weights
)

# Construire le graphe
metro_graph <- graph_from_data_frame(edge_list, directed = FALSE)

# Vérifier si le graphe est connexe
if (!is_connected(metro_graph)) {
  cat("Le graphe n'est pas connexe. Vérifiez les données.\n")
}

# Appliquer l'algorithme de Kruskal pour obtenir le sous-graphe recouvrant minimal
mst <- mst(metro_graph, weights = E(metro_graph)$weight)

# Calculer une disposition fixe pour les graphes
layout_coords <- layout_with_fr(mst)  # Algorithme de disposition Fruchterman-Reingold

# Graphe 1 : Sous-graphe recouvrant minimal (par défaut)
par(mfrow = c(1, 2))  # Diviser l'espace graphique en 2 colonnes
plot(mst, vertex.label = V(mst)$name, main = "Sous-graphe recouvrant minimal", layout = layout_coords)

# Graphe 2 : Sous-graphe recouvrant minimal avec stations clés
V(mst)$color <- "lightblue"  # Couleur par défaut
V(mst)$color[V(mst)$name == "La Défense (Grande Arche)"] <- "red"
V(mst)$color[V(mst)$name == "Jussieu"] <- "green"
plot(mst, vertex.label = V(mst)$name, main = "Sous-graphe recouvrant minimal (stations clés en couleur)", layout = layout_coords)

# Afficher les caractéristiques du graphe
cat("Nombre de sommets :", vcount(mst), "\n")
cat("Nombre d'arêtes :", ecount(mst), "\n")

# Calculer et afficher les degrés des stations clés
degree_la_defense <- degree(mst, v = "La Défense (Grande Arche)")
degree_jussieu <- degree(mst, v = "Jussieu")
cat("Degré de La Défense (Grande Arche) :", degree_la_defense, "\n")
cat("Degré de Jussieu :", degree_jussieu, "\n")

