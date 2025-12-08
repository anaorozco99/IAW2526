<!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8">
  
        <title></title>
        
    </head>
    <body>
        
    <?php
    echo "El uso de switch: <br><br>";

    $dia= date('N');
    switch($dia) {
        case 0:
            echo "Hoy es domingo";
        break;
        
        case 1:
            echo "Hoy es lunes";
        break;

        case 2:
            echo "Hoy es martes";
        break;

        case 3:
            echo "Hoy es miércoles";
        break;

        case 4:
            echo "Hoy es jueves";
        break;

        case 5:
            echo "Hoy es viernes";
        break;
        
        case 6:
            echo "Hoy es sábado";
        break;
        
        default:
        echo "Ha habido un error, intentalo de nuevo mas tarde";

    }
    ?>
        
        
    </body>
</html>