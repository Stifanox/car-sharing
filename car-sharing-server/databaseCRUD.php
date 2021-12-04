<?php
header("Access-Control-Allow-Origin: *");
include "Database.php";
$database = new Database();

$action = $_GET["action"];

switch ($action) {
    case 'getAllUsers':
        echo(json_encode($database->getAllUsers()));
        break;
    case "changePrivilege":
        $id = $_POST["id"];
        $privilege = $_POST["privilege_id"];
        $result = $database -> changePrivilege((int)$id,(int)$privilege); 
        if($result){
            $database ->success(json_encode($result));
        }else{
            $database ->error("Couldn't change privilege of user. Bad request to database");
        }
        break;
    case "changePassword":
        $id = $_POST["id"];
        $password = $_POST["password"];
        $result = $database ->changePassword($id,$password);
        
        if($result){
            $database ->success($result);
        }else{
            $database ->error("$result");
        }
        break;

    case "getBrandsAndPrices":
        $brands = $database -> customQuery("SELECT * FROM car_brands");
        $prices = $database -> customQuery("SELECT * FROM prices");
        $bodies = $database -> customQuery("SELECT * FROM body_types");
        $database ->success(array("success"=>true,"brands" =>$brands->fetch_all(MYSQLI_ASSOC),"prices"=>$prices->fetch_all(MYSQLI_ASSOC),"bodies"=> $bodies->fetch_all(MYSQLI_ASSOC)));
        break;

    case "addNewOffer":
        $brand= $_POST["brand"];
        $horsepower= $_POST["horsepower"];
        $price= $_POST["price"];
        $description = $_POST["description"];
        $fuel_per_100_km = $_POST["fuel_per_100_km"];
        $how_long_to_100 = $_POST["how_long_to_100"];
        $image_source = $_POST["image_source"];
        $model = $_POST["model"];
        $body_id = $_POST["body_id"];
        $result = $database ->addNewOffer((int)$brand,(int)$horsepower,(int)$price,$description,(float)$fuel_per_100_km,(float)$how_long_to_100,$image_source,$model,(int)$body_id);

        if($result){
            $database -> success("Success");
        }else{
            $database -> error("Couldn't add new record to database");
        }
        break;
    case "getOffer":
        $result = $database -> getOffer();
        $database -> success($result ->fetch_all(MYSQLI_ASSOC));
        break;
    case "getOfferById":
        $id = $_POST["id"];
        $result = $database -> getOfferById((int)$id);
        $database ->success($result->fetch_all(MYSQLI_ASSOC));
        break;
    case "getOfferStatus":
        $id = $_GET["id"];
        $result = $database -> getCarStatusOffer((int)$id);
        $database ->success($result ->fetch_all(MYSQLI_ASSOC));
        break;
    case "makeReservation":
        $user_id = $_POST["user_id"];
        $offer_id = $_POST["offer_id"];
        $date_start = $_POST["date_start"];
        $date_end = $_POST["date_end"];
        $status_id = $_POST["status_id"];
        $acception_id = $_POST["acception_id"];
        $result = $database -> makeReservation((int)$user_id,(int)$offer_id,$date_start,$date_end,(int)$status_id,(int)$acception_id);
        if($result){
            $database -> success("$user_id");
        }else{
            $database ->error("Couldn't make reservation");
        }
        break;
    case "getAllReservationsByUserId":
        $user_id = $_POST["user_id"];
        $archive_array = $database -> getArchiveReservationsByUserId((int)$user_id);
        $reservation_array = $database -> getReservationsByUserId((int)$user_id);
        $merge_array = array_merge($reservation_array->fetch_all(MYSQLI_ASSOC),$archive_array->fetch_all(MYSQLI_ASSOC));
        $database -> success($merge_array);
        break;
    case "cancelBooking":
        $reservation_id = $_POST["reservation_id"];
        $result = $database -> cancelBooking((int)$reservation_id);

        if($result) $database->success("success");
        else $database ->error("Couldn't remove reservation");

        break;

    case "getAllReservationsByOfferId":
        $offer_id = $_POST["offer_id"];
        $archive_array = $database -> getArchiveReservationsByOfferId((int)$offer_id);
        $reservation_array = $database -> getReservationsByOfferId((int)$offer_id);
        $merge_array = array_merge($archive_array->fetch_all(MYSQLI_ASSOC),$reservation_array->fetch_all(MYSQLI_ASSOC));
        $database ->success($merge_array);
        break;
    case "returnCar":
        $reservation_id = $_POST["reservation_id"];
        $acception_status = $_POST["acception_status"];
        $result = $database -> returnCar((int)$reservation_id,$acception_status);

        if($result) $database ->success("success");
        else $database ->error("Couldn't return car xd");
        break;
    case "acceptBooking":
        $offer_id = $_POST["offer_id"];
        $user_id = $_POST["user_id"];

        $database -> rejectOtherBooking((int)$offer_id,(int)$user_id);
        $database ->success("success");
        break;
    case "changeDate":
        $date_start = $_POST["date_start"];
        $date_end = $_POST["date_end"];
        $reservation_id = $_POST["reservation_id"];

        $result = $database -> changeDate($reservation_id,$date_start,$date_end);

        if($result) $database -> success("success");
        else $database -> error("Couldn't make change of date");
        
        break;
    case "doesHaveDetencion":
        $user_id = $_GET["user_id"];
        $result = $database ->doesHaveAnyDetencion((int)$user_id);
        $canMakeReservation = count($result ->fetch_all(MYSQLI_ASSOC)) > 0 ? "true":"false";
        $database -> success($canMakeReservation);
        break;
    case "turnScheduler":
        $type=$_GET["type"];
        $result = $database -> customQuery("SET GLOBAL event_scheduler='$type'");
        if($result) $database ->success("success");
        else $database -> error("Couldn't change scheduler");
        break;
    default:
        $database ->error("Couldn't resolve request");
        break;
}