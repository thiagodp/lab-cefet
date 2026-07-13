<?php /** @author Thiago Delgado Pinto */

if ( ! extension_loaded('zip') ) {
    die( 'Extensão "zip" não habilitada. Habilite em seu php.ini (rode "php --ini" para saber onde ele está).' );
}

$argv = $_SERVER[ 'argv' ] ?? null;
if ( $argv === null ) {
    die( 'Argumentos não disponíveis.' );
}
$file = $argv[ 1 ] ?? null;
if ( $file === null ) {
    die( 'Arquivo não informado. Use: php unzip.php <arquivo.zip> [<pasta>]' );
}

$name = $argv[ 2 ] ?? basename( $file );
echo 'Extraindo para ', $name, PHP_EOL;

$zip = new ZipArchive();
if ( $zip->open( $file ) === true ) {
    $zip->extractTo( $name );
    $zip->close();
    echo 'Pronto.', PHP_EOL;
} else {
    echo 'Erro ao descompactar arquivo ZIP.', PHP_EOL;
}