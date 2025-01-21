# Charger les bibliothèques nécessaires
library(dplyr)
library(igraph)
library(data.table)

# Charger les données
arbres <- fread("C:/Users/hp/OneDrive/Bureau/sgl-arbres-urbains-wgs84.csv")

# Sélectionner les colonnes hauteur et diametre
arbres_selectionnes <- arbres %>% select(hauteur, diametre)

# Remplir les valeurs manquantes par la moyenne
arbres_selectionnes$hauteur[is.na(arbres_selectionnes$hauteur)] <- mean(arbres_selectionnes$hauteur, na.rm = TRUE)
arbres_selectionnes$diametre[is.na(arbres_selectionnes$diametre)] <- mean(arbres_selectionnes$diametre, na.rm = TRUE)

# Définir les seuils s1 et s2 (par exemple, 10% de la moyenne des hauteurs et diamètres)
s1 <- 0.1 * mean(arbres_selectionnes$hauteur, na.rm = TRUE)
s2 <- 0.1 * mean(arbres_selectionnes$diametre, na.rm = TRUE)

# Initialisation des matrices de relations
n <- nrow(arbres_selectionnes)

# Vectorisation des conditions IQ et PQ
hauteur_diff <- outer(arbres_selectionnes$hauteur, arbres_selectionnes$hauteur, "-")
diametre_diff <- outer(arbres_selectionnes$diametre, arbres_selectionnes$diametre, "-")

# Relation IQ : arbres proches en hauteur et diamètre
relation_IQ <- (abs(hauteur_diff) <= s1) & (abs(diametre_diff) <= s2)

# Relation PQ : arbres éloignés en hauteur et diamètre
relation_PQ <- (hauteur_diff > s1) & (diametre_diff > s2)

# Convertir les matrices en type numérique
relation_IQ <- relation_IQ * 1
relation_PQ <- relation_PQ * 1

# Combiner les relations IQ et PQ pour former la relation Q
relation_Q <- relation_IQ + relation_PQ

# Fonction pour la fermeture transitive (algorithme de Warshall)
fermeture_transitive_warshall <- function(matrice) {
  n <- nrow(matrice)
  for (k in 1:n) {
    matrice <- matrice | (matrice[, k] %*% t(matrice[k, ]))
  }
  return(matrice)
}

# Appliquer la fermeture transitive sur la relation Q
relation_Q_transitive <- fermeture_transitive_warshall(relation_Q)

# Visualisation du graphe de la relation Q après fermeture transitive
graphe_Q <- graph_from_adjacency_matrix(relation_Q_transitive, mode = "undirected")
plot(graphe_Q, main = "Graphe de la relation Q après fermeture transitive", vertex.size = 5, vertex.label.cex = 0.7)