# Analyse-des-données-
Projet de quatre partie avec la langage R
PARTIE 1. DETERMINANTS DES SALAIRES (PAR LES MOINDRES CARRES ORDINAIRES)

Vous avez le choix des variables explicatives qui vous semblent pertinentes. Dans tous les cas, vous ferez d’abord
une analyse descriptive de toutes les variables utilisées avant de procéder à l’estimation de votre modèle.
Base de données : ECMOSS

PARTIE 2. CONSTRUCTION D’UNE RELATION BINAIRE ET FERMETURE TRANSITIVE

La base contient des informations sur 709 arbres de la commune de Saint-Germain-en-Laye. A partir des variables
« hauteur » et « diametre » (remplacer les valeurs manquantes éventuelles par la moyenne), créer une relation
binaire Q = IQ + PQ de la manière suivante :
• Arbre « i » IQ Arbre « j » si « i » et « j » sont proches
• Arbre « i » PQ Arbre « j » si « i » et « j » sont éloignés
Vous avez le choix de la notion de proximité que vous souhaitez utiliser. Permettez-moi de vous en suggérer une :
• Arbre « i » IQ Arbre « j » si la valeur de la variable "hauteur" de l'individu "i" appartient à l'intervalle
["hauteur" de l'individu "j" - 𝑠!, "hauteur" de l'individu "j" + 𝑠!] et si la valeur de la variable "diametre" de
l'individu "i" appartient à l'intervalle ["diametre" de l'individu "j" - 𝑠", "diametre" de l'individu "j" + 𝑠"]
• Arbre « i » PQ Arbre « j » si la valeur de la variable "hauteur" de l'individu "i" > "hauteur" de l'individu "j" +
𝑠! et si la valeur de la variable "diametre" de l'individu "i" > "diametre" de l'individu "j" + 𝑠"
Où 𝑠! et 𝑠" sont des seuils que vous définirez.
Quelle est la fermeture transitive de Q ?
Base de données : sgl-arbres-urbains-wgs84 (https://www.data.gouv.fr/fr/datasets/arbres-urbains/)

PARTIE 3. OPTIMISATION SOUS R

Soit le programme suivant: f(x,y,z)=x²+y²+z²-2x-3y+z sur D = {(x,y,z) ∈ ℝ# : x + 2y + z ≤ 4, x + y ≥ 1, x, y, z ≥ 0}
Résolvez à la main, puis résolvez avec R (expliquez le code svp)

PARTIE 4. SOUS-GRAPHE RECOUVRANT OPTIMAL DU METRO PARISIEN

Le fichier « metro_distance_matrix_updated » inclut les stations des 14 lignes actuelles du métro parisien, avec
M[i,j] = nombre de stations entre les stations si elles sont sur une même ligne et M[i,j] = exp(10) si elles sont sur
des lignes différentes.
En utilisant l’algorithme de Kruskal, trouver un sous-graphe recouvrant mininal. Que dire de la structure actuelle du
métro Parisien ? Discuter de l’importance relative des stations « La Defense (Grande Arche) » et « Jussieu ».
