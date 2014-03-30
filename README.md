# EDJ : API Combien gagne votre voisin

Cette API vous permet d'enregistrer et de consulter les votes dans le cadre du 
projet Combien gagne votre voisin.

## Consulter les salaires

Pour retourner le salaire moyen d'un age, d'un sexe et d'une profession donnée, 
utilisez la syntaxe suivante :

```
GET http://edj-cgvv.herokuapp.com/:job/:sex/:age/
```

Par exemple pour obtenir le salaire d'un jardinier de 25 ans :
```
GET http://edj-cgvv.herokuapp.com/631a/male/25/
```

```
{
  "salary": 13927,
  "spo": 61,
  "coeff": 1
}
```