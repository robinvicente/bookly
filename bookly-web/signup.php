<!doctype html>
<html lang="en">
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

    require_once ('dbconnection.php');
    $state = false;
    $stateMail = false;
    $stateUserName = false;
    $StateOfExistenceOfUserName = false;
    $StateOfExistenceOfEmail = false;
    $StatusOfIdenticalPasswords = false;
    $StateOfExistenceOfUserName = false;

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
        function VerificationOfIdenticalPasswords()
        {
            if ($_POST['pass'] === $_POST['repass'])
                $StatusOfIdenticalPasswords = true;
            else
                $StatusOfIdenticalPasswords = false;
            return $StatusOfIdenticalPasswords;
        }
    }

    if(emptyValues() && mailValidation() && userNameValidation() && VerificationOfIdenticalPasswords()) {
        function ExistenceOfUserName()
        {
            global $mysqliConnect;
            global $StateOfExistenceOfUserName;
            $Clean_UserExistenceOfUserName = mysqli_real_escape_string($mysqliConnect , $_POST['user']);

            $queryExistenceOfUserName = "SELECT * FROM usuario WHERE NombreUsuario = '$Clean_UserExistenceOfUserName'";

            if ($resultExistenceOfUserName = mysqli_query($mysqliConnect, $queryExistenceOfUserName)) {
                $number_of_rowsUser = mysqli_num_rows($resultExistenceOfUserName);
                if($number_of_rowsUser >= 1)
                    $StateOfExistenceOfUserName = false;
                else
                    $StateOfExistenceOfUserName = true;
            } else{
                printf("Could not insert record: %s\n", mysqli_error($mysqliConnect));
            }
            return $StateOfExistenceOfUserName;
        }
    }

    if(emptyValues() && mailValidation() && userNameValidation() && VerificationOfIdenticalPasswords()) {
        function ExistenceOfUserEmail()
        {
            global $mysqliConnect;
            global $StateOfExistenceOfUserEmail;
            $Clean_EmailExistenceOfUserEmail = mysqli_real_escape_string($mysqliConnect , $_POST['email']);

            $queryExistenceOfUserEmail = "SELECT * FROM usuario WHERE EmailUsuario = '$Clean_EmailExistenceOfUserEmail'";

            if ($resultExistenceOfUserEmail  = mysqli_query($mysqliConnect, $queryExistenceOfUserEmail)) {
                $number_of_rowsEmail = mysqli_num_rows($resultExistenceOfUserEmail);
                if($number_of_rowsEmail >= 1)
                    $StateOfExistenceOfUserEmail = false;
                else
                    $StateOfExistenceOfUserEmail = true;
            } else {
                printf("Could not insert record: %s\n", mysqli_error($mysqliConnect));
            }
            return $StateOfExistenceOfUserEmail;
        }
    }

    if(emptyValues() && mailValidation() && userNameValidation() && VerificationOfIdenticalPasswords() && ExistenceOfUserName() && ExistenceOfUserEmail())
    {
        $CleanUserName = mysqli_real_escape_string($mysqliConnect , $_POST['user']);
        $CleanUserMail = mysqli_real_escape_string($mysqliConnect , $_POST['email']);
        $CleanUserPasswd = mysqli_real_escape_string($mysqliConnect, password_hash($_POST["pass"], PASSWORD_DEFAULT));
        $CleanUserBirthday = mysqli_real_escape_string($mysqliConnect , $_POST['birthday']);

        $querySignup = "INSERT INTO usuario (NombreUsuario, EmailUsuario, ContraseniaUsuario , FechaNacUsuario) 
                  VALUES('$CleanUserName', '$CleanUserMail', '$CleanUserPasswd', '$CleanUserBirthday')";

        if ($resultQuerySignup = mysqli_query($mysqliConnect, $querySignup)) {
            echo "<p>Registro exitoso</p>";
        } else{
            echo "Error: " . $querySignup . "<br>" . $mysqliConnect->error;
        }

    }elseif (!emptyValues()) {
        print '<p>Llene todos los campos.</p>';
    } elseif (!mailValidation()) {
        print '<p>Correo electrónico no válido.</p>';
    } elseif (!userNameValidation()) {
        print ('<p>Nombre de usuario no valido.</p>');
    } elseif (!VerificationOfIdenticalPasswords()){
        print ('<p>Las contraseñas no son iguales, intentalo de nuevo.</p>');
    } elseif(!ExistenceOfUserName()){
        print ('<p>Este nombre se usuario ya está registrada, prueba con otro.</p>');
    }elseif(!ExistenceOfUserEmail()){
        print ('<p>Este email ya está registrada, prueba con otro.</p>');
    }
?>