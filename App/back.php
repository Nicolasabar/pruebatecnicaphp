<?php
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');

function conectar_bd()
{
    $host = 'localhost'; // Cambiar por la dirección del servidor de base de datos
    $user = 'postgres'; // Cambiar por el nombre de usuario de la base de datos
    $password = 'nicolas123'; // Cambiar por la contraseña de la base de datos
    $database = 'pruebatecnicaphp'; // Cambiar por el nombre de la base de datos

    // Creamos la conexión
    $conn = pg_connect("host=$host dbname=$database user=$user password=$password");

    // Verificamos si la conexión fue exitosa
    if (!$conn) {
        die("Conexión fallida: " . pg_last_error());
    }

    return $conn;
}

function obtenerTablaCandidatos($conn)
{
    $query = "SELECT nombre FROM public.candidatos";
    $result = pg_query($conn, $query);

    if (!$result) {
        // Si hubo un error en la consulta, enviamos un mensaje de error al cliente
        $response = ['message' => 'Hubo un error en la consulta'];
    } else {
        // Si la consulta fue exitosa, construimos un arreglo con los nombres
        $data = [];
        while ($row = pg_fetch_assoc($result)) {
            $data[] = $row['nombre'];
        }

        $response = ['message' => 'Nombres encontrados', 'data' => $data];
    }

    // Enviamos la respuesta JSON al cliente
    echo json_encode($response, JSON_THROW_ON_ERROR, 512);
}

function obtenerRegionesYComunas($conn)
{
    // Consulta para obtener los nombres de las regiones
    $queryRegiones = "SELECT nombre FROM public.regiones";
    $resultRegiones = pg_query($conn, $queryRegiones);

    if (!$resultRegiones) {
        echo json_encode(['message' => 'Hubo un error al obtener las regiones']);
        return;
    }

    // Consulta para obtener los nombres de las comunas
    $queryComunas = "SELECT c.nombre AS comuna, r.nombre AS region
                     FROM public.comunas c
                     INNER JOIN public.regiones r ON c.region_id = r.id";
    $resultComunas = pg_query($conn, $queryComunas);

    if (!$resultComunas) {
        echo json_encode(['message' => 'Hubo un error al obtener las comunas']);
        return;
    }

    // Construir un arreglo con los nombres de regiones y comunas relacionadas
    $data = [];

    while ($rowComunas = pg_fetch_assoc($resultComunas)) {
        $region = $rowComunas['region'];
        $comuna = $rowComunas['comuna'];

        if (!isset($data[$region])) {
            $data[$region] = [];
        }

        $data[$region][] = $comuna;
    }

    // Enviamos los datos al cliente
    echo json_encode(['message' => 'Datos obtenidos', 'data' => $data]);
}


function guardarDatos($nombre, $alias, $rut, $email, $region, $comuna, $candidato, $nosotros)
{
    $host = 'localhost'; // Cambiar por la dirección del servidor de base de datos
    $user = 'postgres'; // Cambiar por el nombre de usuario de la base de datos
    $password = 'nicolas123'; // Cambiar por la contraseña de la base de datos
    $database = 'pruebatecnicaphp'; // Cambiar por el nombre de la base de datos

    // Crear la conexión a la base de datos
    $conn = pg_connect("host=$host dbname=$database user=$user password=$password");

    if (!$conn) {
        die("Conexión fallida: " . pg_last_error());
    }

    // Insertar en la tabla "regiones"
    $queryRegion = "INSERT INTO regiones (nombre) VALUES ('$region')";
    $resultRegion = pg_query($conn, $queryRegion);
    if (!$resultRegion) {
        die("Error al insertar en la tabla regiones: " . pg_last_error());
    }

    // Obtener el ID de la última región insertada
    $regionId = pg_last_oid($resultRegion);

    // Insertar en la tabla "comunas" relacionada con la región
    $queryComuna = "INSERT INTO comunas (nombre, region_id) VALUES ('$comuna', $regionId)";
    $resultComuna = pg_query($conn, $queryComuna);
    if (!$resultComuna) {
        die("Error al insertar en la tabla comunas: " . pg_last_error());
    }

    // Obtener el ID de la última comuna insertada
    $comunaId = pg_last_oid($resultComuna);

    // Insertar en la tabla "candidatos"
    $queryCandidato = "INSERT INTO candidatos (nombre) VALUES ('$candidato')";
    $resultCandidato = pg_query($conn, $queryCandidato);
    if (!$resultCandidato) {
        die("Error al insertar en la tabla candidatos: " . pg_last_error());
    }

    // Obtener el ID del último candidato insertado
    $candidatoId = pg_last_oid($resultCandidato);

    // Insertar en la tabla "nosotros"
    $queryNosotros = "INSERT INTO nosotros (nombre, alias, rut, email, comuna_id, candidato_id) VALUES ('$nombre', '$alias', '$rut', '$email', $comunaId, $candidatoId)";
    $resultNosotros = pg_query($conn, $queryNosotros);
    if (!$resultNosotros) {
        die("Error al insertar en la tabla nosotros: " . pg_last_error());
    }

    // Cerrar la conexión a la base de datos
    pg_close($conn);
}

// Obtener los valores enviados desde JavaScript
$nombre = $_POST['nombre'];
$alias = $_POST['alias'];
$rut = $_POST['rut'];
$email = $_POST['email'];
$region = $_POST['region'];
$comuna = $_POST['comuna'];
$candidato = $_POST['candidato'];
$nosotros = $_POST['nosotros'];

// Llamar a la función para guardar los datos en la base de datos
guardarDatos($nombre, $alias, $rut, $email, $region, $comuna, $candidato, $nosotros);


$conn = conectar_bd();

// Llamamos a la función para obtener los nombres de la tabla "candidatos"
obtenerTablaCandidatos($conn);

// Cerrar conexión
pg_close($conn);
?>
