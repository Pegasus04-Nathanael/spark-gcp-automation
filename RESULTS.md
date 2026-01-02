# Résultats Tests Performance WordCount

## Configuration Tests
- **Fichier** : Shakespeare complet (5.3 MB, 124,456 lignes)
- **Cluster** : 1 Master + 2 Workers (2 cores chacun)
- **Mémoire** : 512 MB par executor

## Résultats

| Test | Executors | Cores/Exec | Total Cores | Temps Spark | Temps Total | Speedup |
|------|-----------|------------|-------------|-------------|-------------|---------|
| 1    | 1         | 1          | 1           | 19.56s      | 28.17s      | 1.00x   |
| 2    | 2         | 1          | 2           | 18.94s      | 27.26s      | 1.03x   |
| 3    | 2         | 2          | 4           | 11.91s      | 20.21s      | 1.64x   |

## Analyse Performance

### Observations
1. **Test 1 vs Test 2** : Gain minimal (3%) avec 2 cores
   - Overhead coordination entre workers > gain parallélisme
   - Fichier trop petit (5.3MB) pour amortir coûts réseau

2. **Test 3** : Meilleur speedup (1.64x avec 4 cores)
   - Utilisation optimale des 2 cores par worker
   - Réduction communication inter-workers

### Limitations Speedup
Le speedup n'atteint pas 4x (théorique) pour plusieurs raisons :

**Loi d'Amdahl** : ~40% du code séquentiel
- Lecture fichier (driver)
- `.collect()` ramène données sur driver
- Écriture finale (Python)

**Overhead distribution** :
- Communication réseau inter-workers
- Sérialisation/désérialisation
- Coordination Master/Workers

**Taille fichier** : 5.3MB trop petit
- Overhead > gain parallélisme
- Avec 1GB+, speedup serait ~3x

## Top 10 Mots

1. **the** : 27,549
2. **and** : 26,037
3. **i** : 19,540
4. **to** : 18,700
5. **of** : 18,010
6. **a** : 14,383
7. **my** : 12,455
8. **in** : 10,671
9. **you** : 10,630
10. **that** : 10,487

**Total** : 59,508 mots uniques
