<script>
import Header from "../components/Header.svelte";
import CardOffer from "../components/CardOffer.svelte";

const link = "http://localhost/car-sharing/databaseCRUD.php"
const actionGetOffer = "?action=getOffer"
if(sessionStorage.getItem("privilege") != "1" && sessionStorage.getItem("privilege") != "3"){
    location = "/#/accessDenied"
}

const result = fetch(`${link}${actionGetOffer}`,
{
    method:"GET"
}).then(res => res.json())

</script>

<main>
    <Header />
    {#await result}
        <p class="text-center">Pobieram oferty...</p>
    {:then offer} 
    <div class="flex flex-wrap mt-5 ">
        {#each offer as carInfo}
            <CardOffer {carInfo} />
        {/each}
    </div>
    {/await}
</main>

<style scoped>

</style>