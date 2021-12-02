<?php

class Database{
    public $conn;

    function __construct()
    {
        $this ->conn = new mysqli("localhost","root","","car_sharing");
        if($this -> conn -> connect_errno){
            die("Nie można było połączyć się z bazą danych");
        }
    }
    public function insertUser(string $username,string $password,string $email,int $privilege):bool
    {
        if($this-> escapeChars([$username,$password,$email])){
            $hashedPassword = $this -> hashPassword($password);
            return $this->conn ->query("INSERT INTO users(`username`,`email`,`password`,`privilege_id`) VALUES('$username','$email','$hashedPassword',$privilege)");
        }
        else{
            return false;
        }
    }
    public function getAllUsers():array|null
    {
        $result = $this -> conn -> query("SELECT users.id,users.username,users.email,roles.role_name FROM users INNER JOIN roles ON users.privilege_id = roles.id");
        return $result -> fetch_all(MYSQLI_ASSOC);

    }
    public function getUserByUsername(string $username):array|null
    {
        if($this ->escapeChars([$username])){
            $result = $this -> conn -> query("SELECT * FROM users WHERE username='$username'");
            return $result -> fetch_array();
        }
    }

    public function login(string $username, string $password):array|null
    {
        if($this -> escapeChars([$username,$password])){
            $result = $this -> conn -> query("SELECT * FROM users WHERE username='$username'");
            $userData = $result -> fetch_assoc();
            if($userData){
                if(password_verify($password,$userData["password"])){
                    return $userData;
                }else{
                    return null;
                }
            }else{
                return null;
            }
        }
        else{
            return null;
        }
    }

    public function changePrivilege(int $id, int $privilate_id)
    {
        return $this -> conn -> query("UPDATE users SET privilege_id=$privilate_id WHERE id=$id");
    }

    public function changePassword(int $id, string $password)
    {
        if($this -> escapeChars([$password])){
            $hashedPassword = $this ->hashPassword($password);
            return $this ->conn ->query("UPDATE users SET `password`='$hashedPassword' WHERE id=$id");
        }
        else{
            return null;
        }
    }

    public function addNewOffer(int $brand, int $horsepower,int $price,string $description, float $fuel_per_100_km, float $how_long_to_100,string $image_source,string $model,int $body_id)
    {
        if($this -> escapeChars([$description,$image_source,$model])){
            return $this ->conn ->query("INSERT INTO offer(brand_id,horsepower,price_id,`description`,fuel_per_100_km,how_long_to_100,image_source,model,body_id)
            VALUES($brand,$horsepower,$price,'$description',$fuel_per_100_km,$how_long_to_100,'$image_source','$model',$body_id)");
        }else{
            return null;
        }
    }
    public function getOffer(){
        return $this -> conn -> query("SELECT offer.id, offer.horsepower, offer.description, offer.fuel_per_100_km,offer.how_long_to_100,offer.image_source, 
        offer.model,car_brands.brand,prices.price,body_types.body_name FROM offer INNER JOIN car_brands ON offer.brand_id = car_brands.id INNER JOIN prices ON
         offer.price_id = prices.id INNER JOIN body_types ON offer.body_id = body_types.id");
    }

    public function getOfferById(int $id)
    {
        return $this -> conn ->query("SELECT offer.id, offer.horsepower, offer.description, offer.fuel_per_100_km,offer.how_long_to_100,offer.image_source, 
        offer.model,car_brands.brand,prices.price,body_types.body_name FROM offer INNER JOIN car_brands ON offer.brand_id = car_brands.id INNER JOIN prices ON
         offer.price_id = prices.id INNER JOIN body_types ON offer.body_id = body_types.id WHERE offer.id = $id");
       
    }
    public function getCarStatusOffer(int $id)
    {
        return $this -> conn -> query("SELECT s.status_name, r.user_id FROM reservations r INNER JOIN `status` s ON s.id=r.status_id WHERE r.offer_id = $id");
    }
    public function makeReservation(int $user_id,int $offer_id, string $date_start,string $date_end,int $status_id,int $acception_id)
    {
        if($this -> escapeChars([$date_start,$date_end])){
            return $this -> conn ->query("INSERT INTO reservations(`user_id`,offer_id,date_start,date_end,status_id,acception_id) VALUES ($user_id,$offer_id,'$date_start','$date_end',$status_id, $acception_id)");
        }
        else{
            return null;
        }
    }
    public function customQuery(string $query)
    {
        return $this -> conn ->query($query);
    }

    private function escapeChars(array $dataToCheck):bool{
        foreach($dataToCheck as $value){
            if($value != $this ->conn ->real_escape_string($value)){
                return false;
            }
        }
        return true;
    }

    private function hashPassword(string $password):string{
        return password_hash($password,PASSWORD_DEFAULT);
    }

    public function error(string $reason = ""):void
    {
        echo(json_encode(array("error" => $reason)));
        $this -> conn -> close();
        exit();
    }
    public function success(string|array $message){
        if(gettype($message)=="array"){
            echo(json_encode($message));
        }else{
            echo(json_encode(array("success" => $message)));
        }
        $this -> conn -> close();
    }
}