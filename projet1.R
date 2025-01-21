# 1. Charger la bibliothèque 'haven' pour lire les fichiers .dta
library(haven)

# 2. Charger les données à partir du fichier .dta
ecmoss_data <- read_dta("C:/Users/hp/OneDrive/Bureau/Ecmoss_2006.dta")

# 3. Vérification des premières lignes du jeu de données
head(ecmoss_data)

# 4. Résumé statistique des données
summary(ecmoss_data)

# 5. Vérification des colonnes spécifiques dans les données
names(ecmoss_data)

# 6. Résumé statistique pour certaines colonnes spécifiques
summary(ecmoss_data[, c("s_net", "age_r", "sexe_r", "cs_r", "nbheur")])

# 7. Nettoyage des données : suppression des valeurs manquantes dans 's_net'
ecmoss_data_clean <- ecmoss_data[!is.na(ecmoss_data$s_net), ]

# 8. Création des histogrammes pour les variables d'intérêt : 's_net', 'age_r', 'nbheur'

# Histogramme pour 's_net' (Salaire Net)
hist(ecmoss_data_clean$s_net, 
     main = "Distribution du Salaire Net", 
     xlab = "Salaire Net", 
     col = "blue", 
     border = "black", 
     breaks = 20)  # Ajustez 'breaks' pour définir le nombre de barres

# Ajouter une courbe de densité pour 's_net'
lines(density(ecmoss_data_clean$s_net, na.rm = TRUE), col = "red", lwd = 2)

# Histogramme pour 'age_r' (Âge)
hist(ecmoss_data_clean$age_r, 
     main = "Distribution de l'Âge", 
     xlab = "Âge", 
     col = "green", 
     border = "black", 
     breaks = 15)

# Ajouter une courbe de densité pour 'age_r'
lines(density(ecmoss_data_clean$age_r, na.rm = TRUE), col = "blue", lwd = 2)

# Histogramme pour 'nbheur' (Nombre d'Heures Travaillées)
hist(ecmoss_data_clean$nbheur, 
     main = "Distribution des Heures Travaillées", 
     xlab = "Heures", 
     col = "red", 
     border = "black", 
     breaks = 20)

# Ajouter une courbe de densité pour 'nbheur'
lines(density(ecmoss_data_clean$nbheur, na.rm = TRUE), col = "green", lwd = 2)

# 9. Résumé statistique des colonnes d'intérêt
summary(ecmoss_data_clean$s_net)
summary(ecmoss_data_clean$age_r)
summary(ecmoss_data_clean$nbheur)

# 10. Estimation du modèle MCO (Moindres Carrés Ordinaires)
model_mco <- lm(s_net ~ age_r + sexe_r + cs_r + nbheur, data = ecmoss_data_clean)

# 11. Résumé du modèle pour afficher les résultats de la régression
summary(model_mco)

# 12. Vérification des hypothèses du modèle (Analyse des résidus)
# Graphique des résidus pour vérifier l'homoscédasticité et l'indépendance
plot(model_mco$residuals, main = "Graphique des résidus", ylab = "Résidus", col = "blue")

# 13. Analyse des résultats du modèle
# Coefficients du modèle
coefficients(model_mco)

# Interprétation des résultats
# - Les coefficients indiquent l'effet de chaque variable explicative sur le salaire net.
# - Par exemple, le coefficient de 'age_r' montre l'impact de l'âge sur le salaire net.
# - Le sexe, la catégorie socio-professionnelle (cs_r), et le nombre d'heures travaillées (nbheur) ont également un impact significatif.
# - Le R² indique la proportion de la variance du salaire net expliquée par le modèle.

# 14. Vérification de la qualité du modèle
# Vérification du R², qui montre la proportion de variance expliquée par le modèle
summary(model_mco)$r.squared

# Résidus pour vérifier l'homoscédasticité
plot(model_mco$fitted.values, model_mco$residuals, 
     main = "Graphique des résidus vs ajustements",
     xlab = "Valeurs ajustées", ylab = "Résidus", 
     col = "red")
abline(h = 0, col = "black")
par(mfrow = c(2, 3))
