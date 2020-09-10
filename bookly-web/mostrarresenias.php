<?php

    require_once ('conexion.php');

    $query = "SELECT * from booklydb.resenia";
    $result = mysqli_query($mysqliConnect, $query);
    if(!$result) {
        die('Query Failed'. mysqli_error($mysqliConnect));
    }

    $json = array();
    while($row = mysqli_fetch_array($result)) {
        $json[] = array(
            'title' => $row['TituloResenia'],
            'book' => $row['LibroAReseniar'],
            'desc' => $row['DescripcionResenia'],
            'stars' => $row['ValoracionResenia'],
        );
    }

    $jsonstring = json_encode($json);
    echo $jsonstring;
?>