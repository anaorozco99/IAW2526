<?php
/*
DatabaseService.php
Servicio para la conexión a la base de datos

⚠️ IMPORTANTE PARA EL EXAMEN:
- Este archivo es IGUAL para todos los ejercicios
- SOLO cambia el $db_name si te dan otra base de datos
- El resto NO SE TOCA
*/

class DatabaseService {

    // ========================================
    // CONFIGURACIÓN DE LA BASE DE DATOS
    // ========================================
    // ⚠️ Si te dan otra base de datos, cambia solo estas líneas:
    private $db_host = "localhost";
    private $db_name = "tienda";        // ← CAMBIAR aquí si te dan otro nombre
    private $db_user = "usuario";
    private $db_password = "usuario";
    // ========================================

    private $connection = null;

    /**
     * Obtiene la conexión a la base de datos
     * NO TOCAR ESTA FUNCIÓN
     */
    public function getConnection(){

        if ($this->connection == null) {
            $this->connection = new PDO("mysql:host=$this->db_host;dbname=$this->db_name", $this->db_user, $this->db_password);
        }

        return $this->connection;
    }
}
