<?php

header("Access-Control-Allow-Origin: *");
include "Database.php";
$username = $_POST["username"];
$password = $_POST["password"];
$email = $_POST["email"];
$privilege = $_POST["privilege"];
$database = new Database();

//function

$doesUserExist = $database -> getUserByUsername($username);

$doesUserExist ? $database -> error("user exist"):null;

$success = $database -> insertUser($username,$password,$email,(int)$privilege);


if($success){
    $database -> success("userAdded");
}else{
   $database -> error("Couldn't add user to database");
}
