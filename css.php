<!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="">
        <style>
            .resaltar{
                color:blue;
                font-weight:bold;
            }
        </style>
    </head>
    <body>
       <?php
        echo "Holi";
        $v1="casa";
        $v2="CASA";
        $resultado=strcmp($v1,$v2);
        echo $resultado;




        echo "<br>";
        $miArray=array(1,2,3,4,5);
        echo "El tamaño de mi array es " . sizeof($miArray);
        echo "<br>";
        echo $miArray[2];
        echo "<br>";
        echo var_dump($miArray);
       ?>
        
        <script src="" async defer></script>
    </body>
</html>