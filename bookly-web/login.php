<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="Styles/login.css">
    <title>Login | Bookly </title>
</head>
<body>
    <article class="central-container">
        <h1>Accede a Bookly</h1>
        <div class="inputs">
            <form action="login.php" method="post">
                <input type="email" name="email" placeholder="Correo electrónico" required>
                <input type="password" name="passwd" placeholder="Contraseña" required>
                <input type="submit" placeholder="Ingresar" value="Submit">
            </form>
        </div>
    </article>

</body>
</html>

<?php
    require_once 'dbconnection.php';

    $state = false;
    $stateMail = false;
    $stateUserName = false;

    function emptyValues()
    {
        if(!empty($_POST["email"]) && !empty($_POST["passwd"]))
        {
            $state = true;
        }
        else
            $state = false;
        return $state;
    }
    /*function mailValidation()
    {
        if ((filter_var($_POST["email"], FILTER_VALIDATE_EMAIL)) == true)
        {
            $stateMail = true;
        }else
        {
            $stateMail = false;
        }
        return $stateMail;
    }*/
    function mysql_fix_string($connectionDatabase, $string)
    {
        if (get_magic_quotes_gpc())
            $string = stripcslashes($string);
        return $connectionDatabase->real_escape_string($string);
    }

    if (emptyValues())
    {
        $email = mysql_fix_string($connectionDatabase, $_POST['email']);
        $passwd = mysql_fix_string($connectionDatabase, $_POST['passwd']);

        $query   = "SELECT * FROM usuario WHERE EmailUsuario = '$email'";
        $result  = $connectionDatabase->query($query);

        if (!$result) die ("Usurio no encontrado");
        elseif ($result->num_rows)
        {
            $row = $result->fetch_array(MYSQLI_NUM);
            if($passwd === $row[3])
                echo "iguales";
            if (password_verify($passwd, $row[3]))
            {
                session_start();
                $_SESSION['NombreUsuario']=$row[1];
                echo htmlspecialchars("$row[0]:
                            has ingresado como '$row[0]'");
                die ("<p><a href='diario.php'>Click para continuar
                                </a></p>");
            }
            else
                echo "lol";
        }
        else die("Usuario/password incorrecto");
    }

?>