<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Libros | Booly</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="Styles/normalize.css">
    <link href="https://unpkg.com/ed-grid@3.0.0/src/css/ed-grid.min.css" rel="stylesheet">
    <link rel="stylesheet" href="Styles/book.css">
    <link rel="stylesheet" href="Styles/styles-index.css">
</head>
<body>
    <header class="top-bar">
        <div class="central-grid">
            <div class="central-grid-left">
                <div class="home-logo">
                    <ul>
                        <li class="bookly-home"><a href="">Bookly</a></li>
                        <li class="why" ><a href="bookly-app.php">Reseñas</a></li>
                        <li class="specs" ><a href="#">Generos</a></li>
                        <li class="about" ><a href="books.php">Libros</a></li>
                    </ul>
                </div>
            </div>
            <div class="central-grid-right">
                <ul>
                    <li class="box-signup" ><a class="box-signup-right" href="signup.php">Logout</a></li>
                </ul>
            </div>
        </div>
    </header>
    <article class="s-center">
        <?php
            require_once('dbconnection.php');
            $sql = "SELECT  libro.Titlulolibro, libro.AutorLibro, libro.EditorialLibro, libro.PublicacionLibro FROM libro";
            $result = mysqli_query($mysqliConnect, $sql);

            if (mysqli_num_rows($result) > 0) {
                // output data of each row
                while($row = mysqli_fetch_assoc($result)) {
                    print ("<p>" ."Titulo: " . $row["Titlulolibro"]. "<br>" ."Autor: " . $row["AutorLibro"]. "<br>" .  "Editorial: "
                        . $row["EditorialLibro"] . "<br>" ."Fecha de Publicación: " . $row["PublicacionLibro"] ."<br><br><br>" . "<p>" );
                }
            } else {
                echo "0 results";
            }
            mysqli_close($mysqliConnect);
        ?>
    </article>
</body>
</html>
