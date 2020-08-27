<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="Styles/normalize.css">
    <link rel="stylesheet" href="Styles/styles-signup.css">
    <title>Document</title>
</head>
<body>
        <article class="content">
            <div class="principal-center">
                <div class="box">
                    <div class="central">
                        <h1>Únete a Bookly hoy</h1>
                    </div>
                    <div class="second">
                        <h2>Regístrate</h2>
                    </div>
                    <div class="inputs">
                        <form action="signup.php" method="post">
                            <input type="text" name="user" placeholder="Nombre de usuario" autofocus>
                            <input type="text" name="email" placeholder="Correo electrónico" autofocus>
                            <input type="password" name="pass" placeholder="Contraseña" autofocus>
                            <input type="password" name="repass" placeholder="Confirmar contraseña" autofocus>
                            <h2>Fecha de nacimiento</h2>
                            <input type="date" name="birthday" placeholder="Fecha de nacimiento" autofocus>
                            <input type="submit" value="Registarme">
                        </form>
                    </div>
                </div>
            </div>
        </article>
</body>
</html>
<?php
    include_once "dbconnection.php";

    $state = false;
    $stateMail = false;
    $stateUserName = false;

    function emptyValues()
    {
        if(!empty($_POST["user"]) && !empty($_POST["email"]) && !empty($_POST["pass"])
            && !empty($_POST["repass"]) && !empty($_POST["birthday"]))
        {
            $state = true;
        }
        else
            $state = false;
        return $state;
    }

    function mailValidation()
    {
        if ((filter_var($_POST["email"], FILTER_VALIDATE_EMAIL)) == true)
        {
            $stateMail = true;
        }else
        {
            $stateMail = false;
        }
        return $stateMail;
    }
    function userNameValidation()
    {
        if (preg_match('/^[a-zA-Z0-9]{5,}$/', $_POST["user"])) { // for english chars + numbers only
            $stateuserName = true;
        }else{
            $stateuserName = false;
        }
        return $stateuserName;
    }
    if(emptyValues() && mailValidation() && userNameValidation()) {
        if ($_POST['pass'] === $_POST['repass']) {
            $UserName = $_POST['user'];
            $UserMail = $_POST['email'];
            $UserPasswd = password_hash($_POST["pass"], PASSWORD_DEFAULT);
            $UserBirthday = $_POST['birthday'];

            $query = "INSERT INTO usuario (NombreUsuario, EmailUsuario, ContraseniaUsuario , FechaNacUsuario) 
                  VALUES('$UserName', '$UserMail', '$UserPasswd', '$UserBirthday')";
            $result = $connectionDatabase->query($query);

            if ($connectionDatabase->query($query) === TRUE) {
                echo "<p>Registro exitoso</p>";
            } elseif(!$result) {
                echo "Error: " . $query . "<br>" . $connectionDatabase->error;
            }
            $connectionDatabase->close();

        }else
            print '<p>Las contraseñas no coinciden, intentalo de nuevo</p>';
    }elseif(!emptyValues())
    {
        print '<p>Llene todos los campos</p>';
    }elseif (!mailValidation())
    {
        print '<p>Correo electrónico no válido</p>';
    }elseif (!userNameValidation())
    {
        print ('<p>Nombre de usuario no valido</p>');
    }
?>