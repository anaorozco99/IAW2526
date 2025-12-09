<?php
$numero1=7;
$numero2=5;
$numero3=65;
$numero4=3.5;


echo "Esto es una suma: ";
echo $numero4 + $numero1;
echo "<br>";

echo "Esto es una resta: ";
echo $numero3 - $numero2;
echo "<br>";

echo "Esto es una multiplicación: ";
echo $numero1 * $numero3;
echo "<br>";

echo "Esto es una división: ";
echo $numero3 / $numero2;
echo "<br>";

echo "Esto es una potencia: "; //Multiplicamos el valor de $numero3=65 por el número de veces del valor $numero1=7 (es decir 65*65*65*65*65*65*65(65^7)= 4902227890625)
echo $numero3 ** $numero1;
echo "<br>";

echo "Esto es un resto: "; //Esto le llaman "módulo" también, sirve para obtener el resto de una división, es decir lo que ya no se puede dividir de forma exacta, lo que ponemos en un semicírculo.
echo $numero2 % $numero3;
echo "<br>";



?>