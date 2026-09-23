# 🟩 Hulk Arena — Concept de map (20 joueurs)

**Règle de base :** 20 joueurs, 1 est tiré au sort pour devenir **Hulk**. Il doit éliminer les 19 autres avant la fin du timer.
Les survivants ne peuvent pas tuer Hulk → ils doivent **fuir, se cacher et survivre**.

---

## Les 3 visuels générés

| Fichier | Usage |
|---|---|
| `01-plan-aerien.png` | **Vue du dessus** → sert de plan de construction dans Roblox Studio (placement des zones, boucles de fuite) |
| `02-vue-isometrique.png` | **Vue 3/4 isométrique** → sert pour le thumbnail / l'icon du jeu |
| `03-ambiance-hulk.png` | **Ambiance cinématique** → sert pour la page du jeu, le gamepass art, les backgrounds de loading screen |

---

## Layout de la map (à reproduire dans Studio)

Taille recommandée : **~250 x 250 studs**, une seule "île" avec du vide autour (pas de sortie possible).

### Les 7 zones

1. **Plaza centrale (zone ouverte, ~60x60)**
   C'est la zone **dangereuse** : Hulk y est imbattable car il saute loin.
   Mets-y peu de couverture (2-3 voitures, une fontaine) → traverser = risqué.
   💡 *Design :* récompense la traversée rapide (raccourci vers la zone d'après) mais punit la moindre hésitation.

2. **Tour d'échafaudage centrale (2-3 étages)**
   Point central de verticalité. Hulk peut grimper → **toujours 2 escaliers/échelles minimum**, jamais 1 seul (sinon c'est une mort garantie, donc frustrante).
   Le dernier étage = plateforme étroite : excellent pour esquiver, mais sans issue → bonne tension.

3. **Quartier de briques (bâtiments + toits accessibles)**
   Le cœur du gameplay : les toits sont reliés par des **catwalks en bois** → un parcours en hauteur quasi continu.
   En dessous : ruelles étroites où Hulk (large) est ralenti → **zone de mix-up**, les joueurs peuvent descendre au dernier moment.

4. **Chantier de construction (grue + étages ouverts)**
   Plateformes à hauteurs décalées, beaucoup de sauts. Grue = point d'observation + long saut possible.
   Zone **skill-based** : les bons joueurs y survivent longtemps.

5. **Aire de jeux / parc (toboggan, fontaine, arbres ronds)**
   Zone **safe early-game** (loin du spawn de Hulk). Le toboggan = seule zone où Hulk est trop large pour passer → **vrai safe spot** mais très visible.

6. **Containers + bennes à ordures (couverture au sol)**
   Blocs de couverture pour **casser la ligne de vue** de Hulk. C'est ce qui rend la map jouable : il ne doit jamais voir les 19 joueurs d'un coup.
   ⚠️ Garde des **espaces entre les containers** assez larges pour qu'un joueur passe mais que Hulk doive contourner ou casser.

7. **Boucle périphérique (le "ring" extérieur)**
   Un chemin qui fait **le tour complet de la map**, toujours à la même hauteur (plat, rapide).
   C'est la **règle d'or** du mode : un survivant qui court la boucle ne doit jamais être coincé.

---

## Règles d'équilibrage pour 20 joueurs

- ✅ **Aucun cul-de-sac sans échappatoire** : chaque impasse doit avoir une échelle, une caisse, ou un trou dans un mur.
- ✅ **Min. 3 chemins** entre chaque zone (gauche / droite / par le haut).
- ✅ **Couverture visuelle partout** : depuis le centre, Hulk ne doit voir que ~40% de la map.
- ✅ **Verticalité** : Hulk saute haut, donc le haut n'est PAS safe — il faut des **passages bas** (tuyau, dessous de camion, vide sanitaire) que lui ne peut pas emprunter.
- ⚠️ **Pas de safe spot absolu** sinon les joueurs y campent → les caches doivent être trouvables (une seule entrée, ou besoin de sauter = bruit).
- ⏱️ **Timer de round : 2 min 30** → assez long pour que Hulk trouve tout le monde, assez court pour enchaîner les parties.

## Idées de mécaniques à ajouter

| Mécanique | Effet |
|---|---|
| **Système de bruit** | Sauter / casser fait du bruit → Hulk voit un ping sur la minimap. Rend la fuite stressante. |
| **Rage de Hulk** | Après 45s, Hulk passe en rage : +vitesse, mais la map devient plus lumineuse/visible → contrepartie. |
| **Caisses destructibles** | Hulk casse les murs → la map change en cours de partie, les caches d'il y a 30s n'existent plus. |
| **Dernier survivant = bonus** | Le dernier en vie gagne des points x3 → encourage à ne pas se cacher tout le round. |

---

## Prochaines étapes suggérées

1. Choisir un des 3 visuels comme référence principale.
2. Bloquer la map dans Studio en **greybox** (formes simples, pas de déco) → tester le flow.
3. Ajouter la déco seulement après avoir validé les distances de saut de Hulk.
4. Je peux ensuite t'écrire les scripts Lua (sélection aléatoire de Hulk, timer, round system, minimap/ping).
