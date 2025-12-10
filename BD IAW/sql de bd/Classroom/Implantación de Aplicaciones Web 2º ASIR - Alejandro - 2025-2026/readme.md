\# Instalación de la pila LAMP (Linux, Apache, MariaDB, PHP)



\## 1. Actualizar el sistema



Antes de instalar, actualizamos los paquetes del sistema:



&nbsp;	sudo apt update \&\& sudo apt upgrade -y



---



\## 2. Instalación de Apache



Instalamos el servidor web Apache:



&nbsp;	sudo apt install apache2 -y



Comprobamos el estado del servicio:



&nbsp;	sudo systemctl status apache2



Para comprobar que funciona apache debemos conectar el navegador a la ip del EC2.

Para ello buscamos ip pública en los detalles de la instancia y debemos quitar la s del https porque no hemos configurado eso aún.



&nbsp;	http://54.242.151.127/



---



\## 3. Instalación de MariaDB



Instalamos el sistema de gestión de bases de datos:



&nbsp;	sudo apt install mariadb-server -y





Iniciamos y habilitamos el servicio:



&nbsp;	sudo systemctl enable mariadb

&nbsp;	sudo systemctl start mariadb





Aseguramos la instalación:



&nbsp;	sudo mariadb-secure-installation





Respuestas que doy:



-Contraseña actual: Enter (no tenemos contraseña actual)

-Cambiar contraseña root: Y (y la cambiamos)

-Eliminar usuarios anónimos: Y

-No permitir root remoto: Y

-Eliminar base de datos de prueba: Y

-Recargar privilegios: Y



Comprobamos que funciona:



&nbsp;	sudo systemctl status mariadb



---



\## 4. Instalación de PHP



Instalamos PHP en modo FPM



&nbsp;	sudo apt install php-fpm php-mysql -y





Verificamos la versión (ya que me da un error en un paso adelante, lo suyo sería verificar antes de ese paso):



&nbsp;	php -v



Vamos a habilitar un módulo:



&nbsp;	sudo a2enmod proxy\_fcgi setenvif





Habilitamos la configuración de php-fpm: (aquí nos sevirá saber la version de php)



&nbsp;	sudo a2enconf php8.3-fpm



---



\## 5. Comprobar PHP



Creamos un archivo de prueba en el directorio web:



&nbsp;	sudo nano /var/www/html/info.php





Contenido del archivo:



<?php

phpinfo();

?>





Guardamos y abrimos en el navegador:





Debe mostrarse la página con información de PHP.



---



\## 6. Comprobamos PHP con MariaDB





Crear archivo de prueba:



&nbsp;	sudo nano /var/www/html/mariadb.php



Dentro pegamos y adaptamos el siguiente código:



<?php



// Bloque para probar la conexión a la base de datos

echo "<h1>Prueba de conexión a MariaDB</h1>";

$servidor = "localhost";

$usuario\_db = "root";

$contrasena\_db = "usuario";

$nombre\_db = "mysql"; // Usamos la base de datos 'mysql' que siempre existe



try {

&nbsp;   $conn = new PDO("mysql:host=$servidor;dbname=$nombre\_db", $usuario\_db, $contrasena\_db);

&nbsp;   // Configurar el modo de error de PDO para que lance excepciones

&nbsp;   $conn->setAttribute(PDO::ATTR\_ERRMODE, PDO::ERRMODE\_EXCEPTION);

&nbsp;   echo "<p style='color:green;'>¡Conexión a MariaDB exitosa!</p>";

} catch(PDOException $e) {

&nbsp;   echo "<p style='color:red;'>Error en la conexión: " . $e->getMessage() . "</p>";

}



// Cerrar la conexión

$conn = null;

?>











\## 7. Comprobar servicios



Verificamos que todos los servicios estén activos:

&nbsp;	sudo systemctl status apache2

&nbsp;	sudo systemctl status mariadb

&nbsp;	sudo systemctl status php8.3-fpm





---



\## 8. Fin de la instalación



Con esto, el servidor LAMP está funcionando correctamente.

