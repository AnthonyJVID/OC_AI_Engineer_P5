# 🛍️ OC - Projet 5 : Segmentez des clients d’un site e-commerce (Olist)

Ce projet est réalisé dans le cadre du parcours *AI Engineer* d’OpenClassrooms.  
Il s’inscrit dans une mission de consulting pour l’entreprise brésilienne **Olist**, qui souhaite renforcer sa stratégie marketing via une segmentation client exploitable et maintenable.

---

## 🎯 Objectifs

1. **Résoudre une demande urgente** liée au dashboard "Customer Experience" (requêtes SQL ciblées)
2. Réaliser une **segmentation clients** à partir des comportements d’achat et de satisfaction
3. **Proposer une stratégie de mise à jour** de la segmentation pour assurer sa pérennité dans le temps

---

## 🗂️ Contenu du projet

### 1. 📊 Dashboard Customer Experience

- 📄 Fichier : `1_script_102024.sql`
- 4 requêtes SQL ont été développées :
  - Commandes récentes avec retard significatif
  - Vendeurs avec chiffre d’affaires élevé
  - Nouveaux vendeurs performants
  - Codes postaux avec mauvais scores de satisfaction

---

### 2. 🔍 Analyse exploratoire & préparation (`2_notebook_exploration_102024.ipynb`)

- Nettoyage et sélection des variables utiles à la segmentation
- Création d’indicateurs comportementaux : récence, fréquence, montant moyen, satisfaction, etc.
- Visualisations descriptives pour identifier les dynamiques client

---

### 3. 🧠 Essais de segmentation (`3_notebook_essais_102024.ipynb`)

- Application de plusieurs algorithmes non supervisés :
  - K-means, Agglomerative Clustering, DBSCAN
  - RFM enrichi (Récence / Fréquence / Montant)
- Choix du modèle final selon :
  - cohérence métier
  - qualité des clusters (Silhouette Score, visualisation PCA)
- Interprétation marketing de chaque segment

---

### 4. 🕒 Simulation de mise à jour (`4_notebook_simulation_102024.ipynb`)

- Simulation de l’évolution des clusters sur différentes périodes
- Évaluation de la stabilité des segments
- Proposition d’un **rythme de mise à jour** (fréquence recommandée)
- Recommandation de **contrat de maintenance** à destination d’Olist

---

## 📁 Arborescence du projet

```
├── 1_script_102024.sql                  → Requêtes SQL pour le dashboard CX
├── 2_notebook_exploration_102024.ipynb → EDA + Feature Engineering
├── 3_notebook_essais_102024.ipynb      → Clustering et interprétation
├── 4_notebook_simulation_102024.ipynb  → Fréquence de mise à jour
├── données/                            → Dataset Olist (anonymisé)
├── présentation.pptx                   → Support de présentation
└── README.md                           → Présentation du projet
```

---

## 📈 Technologies utilisées

- Python (Jupyter Notebooks)
- `pandas`, `scikit-learn`, `matplotlib`, `seaborn`
- SQL (standard compatible PostgreSQL/SQLite)

---

## 🧠 Auteur

Projet réalisé par **AnthonyJVID** dans le cadre du parcours *AI Engineer* chez OpenClassrooms.

---

## 📄 Licence

Projet pédagogique basé sur un dataset public d’Olist, accessible via [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
