#!/bin/bash

#Vérification des paramètres
#s'ils sont absentss, on met une valeur par défaut
if [ -z $i ]
then
	sortie='galerie.html'
else
	sortie=$i
fi

#Préparation des fichiers et dossiers
echo '' > $sortie
if [ ! -e thumbnails ]
then mkdir thumbnails
fi

echo '<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <title>Mon cahier de recttes</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
  <p>' >> $sortie
  #Génération des miniatures de la page
  #works: mogrify -path miniatures -thumbnail 100x100 *.jpeg
  images='ls *.jpeg'
  for image in $images
  do
    convert $image -thumbnail '200x200>' thumbnails/$image
    echo '<a href="'$image'"><img src="thumbnails/'$image'" alt=""/></a> '>> $sortie
  done

echo '</p>
</body>
</html>' >> $sortie
