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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"></head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<body>' >> $sortie
echo '<div class="container">'>> $sortie
  echo '<div class="row">'>> $sortie

  #Génération des miniatures de la page
  #alsoworks: mogrify -path miniatures -thumbnail 100x100 *.jpeg
  images='*.jpeg'
  for image in $images
  do
    titles=$(echo $image | tr "-" "\n" | tr -d 0-9) #remove numbers & extension

    convert $image -thumbnail '200x200>' thumbnails/$image
    
    #bootstrap style card
    echo '<div class="col-md-4 col-sm-4 col-lg-3" style="margin-top:50px;>'>>$sortie
      echo '<div class="card" style="width: 18rem;">'>> $sortie
        echo '<a href="'$image'"><img class="card-img-top" src="thumbnails/'$image'" alt="Card image cap"></a>'>>$sortie
          echo '<div class="card-body">'>>$sortie
          echo '<h5 class="card-title text-capitalize text-center">'"${titles%.*}"'</h5>'>>$sortie
          echo '<p class="card-text">Some content</p><a href="#" class="btn btn-primary">Go somewhere</a>'>>$sortie
      echo '</div>'>>$sortie
    echo '</div>'>>$sortie
  done


  echo '</div>'>>$sortie
echo '</div>'>>$sortie

echo '
</body>
</html>' >> $sortie
