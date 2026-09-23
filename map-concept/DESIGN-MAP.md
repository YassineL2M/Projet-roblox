# 🗽 Hulk Arena — Map réaliste, ville américaine

**Mode :** 20 joueurs, 1 tiré au sort devient **Hulk**. Il doit éliminer les 19 autres avant la fin du timer.
Les survivants ne peuvent pas le tuer → ils doivent **fuir, se cacher, survivre**.

---

## Les 3 visuels (style réaliste US)

| Fichier | Usage |
|---|---|
| **`10-ville-us-plan-aerien.png`** | **Plan aérien type satellite** → ton plan de construction dans Roblox Studio (placement exact des rues et zones) |
| `11-ville-us-vue-drone.png` | **Vue drone 45°** → thumbnail / icon du jeu, page du jeu |
| `12-ville-us-rue-cinematique.png` | **Rue principale au coucher du soleil, dévastée** → loading screen, bannière, art de gamepass |

> Les anciens visuels style cartoon Roblox sont rangés dans `style-cartoon/`.

---

## Layout de la map

Taille recommandée : **~300 x 300 studs**, district fermé (vide / barrières autoroutières tout autour → impossible de sortir).

### Structure urbaine (le squelette)

- **Grid classique à l'américaine** : grandes avenues larges + rues perpendiculaires → des boucles de fuite lisibles au premier coup d'œil.
- **1 Main Street** (l'artère centrale, commerces, néons) = la zone ouverte traversière, très dangereuse mais le chemin le plus court.
- **Ruelles arrière** entre les immeubles : étroites, bennes à ordures, escaliers de secours → là où Hulk est ralenti parce qu'il est large.
- **Périphérique / highway surélevée** : la vraie "boucle de fuite" en hauteur, tout autour de la map.

### Les 8 zones de gameplay

| # | Zone | Rôle gameplay |
|---|---|---|
| 1 | **Downtown (gratte-ciels)** | Verticalité forte. Toits plats + escaliers de secours + water tanks. Hulk grimpe → les sauts entre toits sont le skill-ceiling de la map. |
| 2 | **Main Street (diner, bar, néons)** | Grande ligne droite = **zone à risque**. Beaucoup de vitrines pour se cacher dedans, mais Hulk traverse les murs. |
| 3 | **Parking du supermarché** | Zone ouverte + couverture (voitures, caddies). Excellent pour le chase : slalom entre les voitures. Le toit du supermarché = accès par la benne. |
| 4 | **Station-service** | Petite zone fermée, beaucoup d'objets, la station de lavage = cache serrée. Très tendu, peu de sorties → à placer loin du spawn de Hulk. |
| 5 | **Quartier résidentiel (cul-de-sac)** | Maisons avec **intérieurs visitables** (portes, escaliers, garages, sous-sols). La zone de cache n°1 : Hulk doit casser les murs. |
| 6 | **École + terrain de foot** | Le plus grand espace ouvert de la map → la pire zone pour un survivant, mais la piste d'athlétisme permet de gagner de la vitesse. |
| 7 | **Parc + terrain de baseball** | Arbres = couverture visuelle, mais cages/bâtiments = cache. Mixte. |
| 8 | **Chantier (grue + échafaudages)** | Zone verticale désordonnée, plateformes à hauteurs décalées, tunnels de chantier trop étroits pour Hulk. |

### Bordures
Autoroute surélevée + voie ferrée + terrains vagues = frontière naturelle. Pas de mur invisible moche : **un escalier qui mène nulle part, un pont coupé**.

---

## Équilibrage pour 20 joueurs

- ✅ **Boucle fermée** : un survivant qui court la périphérie ne doit **jamais** rencontrer de cul-de-sac.
- ✅ **3 chemins minimum** entre chaque zone (rue / ruelle / par les toits).
- ✅ **Couverture visuelle** : depuis Main Street, Hulk ne doit voir que ~40% de la map.
- ✅ **Passages étroits** (tuyau, dessous de camion, vide sanitaire, tunnel de chantier) : là où Hulk **ne passe pas** → ça donne de vrais spots de survie sans être du camping.
- ⚠️ **Pas de safe spot absolu** → chaque cache doit être trouvable (une seule entrée = piège si Hulk rôde).
- ⏱️ **Timer : 2 min 30** par round.

## Mécaniques conseillées

| Mécanique | Effet |
|---|---|
| **Système de bruit** | Courir / sauter / casser une vitre → ping sur la minimap de Hulk. La fuite devient stressante. |
| **Murs destructibles** | Hulk casse les murs en briques → la map change en cours de partie, plus aucune cache n'est sûre. |
| **Rage après 45 s** | Hulk + rapide et casse tout, mais la map s'éclaire → contrepartie pour les survivants. |
| **Voitures = projectiles** | Hulk peut lancer une voiture → tue à distance, et détruit les couvertures du parking. |
| **Dernier survivant x3** | Bonus de points → évite que tout le monde campe. |

---

## Comment construire ça dans Roblox Studio (sans se ruiner en perf)

1. **Greybox d'abord** : formes simples, volumes des immeubles, distances de saut de Hulk à régler. Aucune déco.
2. **Réutilise des blocs modulaires** : 3-4 modèles de maisons, 2 d'immeubles, 1 de magasin → assemblés différemment. Roblox tolère mal 300 objets uniques.
3. **Déco ensuite** : vitrines, néons, bennes, voitures en meshes bas poly, decals (asphalte, briques, pelouse).
4. **Passe en StreamingEnabled** + LOD sur les bâtiments lointains → indispensable pour tenir 20 joueurs.
5. Lumière : **Future Lighting** + un seul Skybox cohérent (coucher de soleil US = gratuit en ambiance).

## Prochaines étapes

1. Dis-moi quelle vue tu valides comme référence principale.
2. Je peux régénérer une variante (New York dense, banlieue californienne, petite ville du Midwest de nuit, base militaire US…).
3. Je peux ensuite t'écrire les scripts Lua : sélection aléatoire de Hulk, timer 2m30, système de round, mort/spectateur, ping de bruit sur minimap, murs destructibles.
