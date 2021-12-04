<?php
header("Access-Control-Allow-Origin: *");
include "Database.php";

$password = $_POST["password"];
$username = $_POST["username"];

$database = new Database();



$user = $database -> login($username,$password);
if(isset($user["id"])){
    $detencion = $database -> doesHaveAnyDetencion($user["id"]);
    $canMakeReservation = count($detencion ->fetch_all(MYSQLI_ASSOC)) > 0 ? true:false;
}
$user ? $infoForUser = array("id" =>$user["id"],"username" => $user["username"],"privilege" =>$user["privilege_id"], "detencion"=> $canMakeReservation): $infoForUser = array("error" =>"Couldn't login");

$database -> success($infoForUser);