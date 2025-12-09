<?php
        $generado = rand(0,999999);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cuadrado color</title>
    <style>
    #cuadrado{width: 300px; height:300px; background-color:<?php echo "#" . $generado;?>}
    </style>
</head>
<body>
    <div id="cuadrado"></div>
    
</body>
</html>