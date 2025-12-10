<?php
/*
DatabaseService.php
Servicio para la conexión a la base de datos
*/

class DatabaseService {

    private $db_host = "localhost";
    private $db_name = "tienda";
    private $db_user = "usuario";
    private $db_password = "usuario";
    private $connection = null;

    /** Obtiene la conexión a la base de datos */
    public function getConnection(){

        if ($this->connection == null) {
            $this->connection = new PDO("mysql:host=$this->db_host;dbname=$this->db_name", $this->db_user, $this->db_password);
        }

        return $this->connection;
    }

    /** Ejecuta una consulta y devuelve todos los resultados */
    public function fetchAll($query) {
        $connection = $this->getConnection();
        $stmt = $connection->query($query);
        return $stmt->fetchAll();
    }
}