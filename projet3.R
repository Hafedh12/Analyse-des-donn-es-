# Définition de la fonction à minimiser
f <- function(v) {
  x <- v[1]
  y <- v[2]
  z <- v[3]
  return(x^2 + y^2 + z^2 - 2*x - 3*y + z)
}

# Fonction pour vérifier les contraintes : 
# Nous vérifions si les contraintes sont violées, en renvoyant une valeur non-négative pour chaque contrainte violée.
constraint <- function(v) {
  x <- v[1]
  y <- v[2]
  z <- v[3]
  
  # Les contraintes sont x + 2y + z <= 4 et x + y >= 1, et x, y, z >= 0
  con1 <- x + 2*y + z - 4  # x + 2y + z <= 4
  con2 <- -(x + y - 1)      # x + y >= 1
  con3 <- x                 # x >= 0
  con4 <- y                 # y >= 0
  con5 <- z                 # z >= 0
  
  # Retourner les contraintes sous forme de vecteur
  return(c(con1, con2, con3, con4, con5))
}

# Initialisation des valeurs de départ
initial_guess <- c(1, 1, 1)

# Utilisation de la fonction optim() avec la méthode "L-BFGS-B" pour les bornes
result <- optim(
  par = initial_guess,     # Valeurs initiales
  fn = f,                  # Fonction à minimiser
  method = "L-BFGS-B",     # Méthode L-BFGS-B qui permet de spécifier des bornes
  lower = c(0, 0, 0),      # Bornes inférieures : x, y, z >= 0
  upper = c(Inf, Inf, Inf), # Bornes supérieures : pas de limite supérieure
  control = list(fnscale = 1)  # Fonction de contrôle
)

# Affichage du résultat
result$par      # Les valeurs de x, y, z minimisant la fonction
result$value    # La valeur minimale de la fonction
