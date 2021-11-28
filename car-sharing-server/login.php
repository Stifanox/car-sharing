<?php
header("Access-Control-Allow-Origin: *");
include "Database.php";

$password = $_POST["password"];
$username = $_POST["username"];

$database = new Database();



$user = $database -> login($username,$password);

$user ? $infoForUser = array("id" =>$user["id"],"username" => $user["username"],"privilege" =>$user["privilege_id"]): $infoForUser = array("error" =>"Couldn't login");

$database -> success($infoForUser);