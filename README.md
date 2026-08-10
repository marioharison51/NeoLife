NeoLife

NeoLife est un projet de fin de master visant à démontrer l’intégration harmonieuse de plusieurs langages et frameworks — Flutter/Dart, Python, C/C++ et JavaScript — dans une application unique de gestion du quotidien.
Ce projet illustre la conception d’un système complet, performant et multiplateforme, alliant backend optimisé et une design moderne et technologies avancées pour offrir une expérience fluide, connectée et adaptée aux besoins de la vie de tous les jours.

Objectif du projet

NeoLife centralise les activités quotidiennes dans une seule interface intuitive:
- Suivi des **dépenses** et gestion financière personnelle  
- Création d’une **liste de courses intelligente** avec suggestions de recettes  
- **Suivi de santé** (repas, activité, sommeil)  
- **Agenda personnel** pour organiser ses rendez‑vous et tâches  
- **Carnet de notes** pour enregistrer ses idées et réflexions  

Chaque module communique avec un **backend Python** qui orchestre les calculs (via C/C++) et les échanges de données avec l’interface web et mobile.

 Architecture technique
 
 Composant  Langage Technologie Rôle 

Frontend Web HTML, CSS, JavaScript Interface utilisateur accessible depuis navigateur 
Frontend Mobile/Desktop Flutter/Dart Application multiplateforme moderne 
Backend Python pour la communication entre les modules 
Modules natifs C / C++ Calculs rapides et traitement logique 
