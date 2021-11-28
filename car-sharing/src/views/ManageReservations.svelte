<script>
import Header from "./Header.svelte";
const link = "http://localhost/car-sharing/databaseCRUD.php"

if(sessionStorage.getItem("privilege") != "1" && sessionStorage.getItem("privilege") != "3"){
    location = "/#/accessDenied"
}


</script>

<main>
    <Header />
    Tu jest zarządzanie rezerwacjami
</main>

<style scoped>

</style>