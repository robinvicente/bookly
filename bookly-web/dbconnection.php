<?php

    $host = 'localhost:3307';
    $databaseUser = 'root';
    $databasePasswd = 'KTLi5p7U';
    $databaseName = 'bookly';

    $connectionDatabase = mysqli_connect($host, $databaseUser, $databasePasswd,$databaseName);

    if (!$connectionDatabase) {
        echo "Error: No se pudo conectar a MySQL." . PHP_EOL;
        echo "Error de depuración: " . mysqli_connect_errno() . PHP_EOL;
        echo "Error de depuración: " . mysqli_connect_error() . PHP_EOL;
        exit;
    }




