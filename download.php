<?php /** @author Thiago Delgado Pinto */

$argv = $_SERVER[ 'argv' ] ?? null;
if ( $argv === null ) {
    die( 'Argumentos não disponíveis.' );
}
$file = $argv[ 1 ] ?? null;
if ( $file === null ) {
    die( 'Arquivo não informado. Use: php download.php <arquivo_a_baixar> [<novo_nome>]' );
}

$name = $argv[ 2 ] ?? basename( $file );
echo 'Salvando para: ', $name, '...', PHP_EOL;

$r = copy( $file, $name );
if ( $r === false ) {
    die( 'Erro ao baixar o arquivo.' );
}
echo 'Salvo.', PHP_EOL;