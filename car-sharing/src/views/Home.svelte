<script>
import CardOffer from "../components/CardOffer.svelte";

import Header from "./Header.svelte";
import ManagementPanel from "./ManagementPanel.svelte";

const privilege = sessionStorage.getItem("privilege")
const link = "http://localhost/car-sharing/databaseCRUD.php"
const getOffer = "?action=getOffer"
let filteredData = []
let rawData = null
const result = fetch(`${link}${getOffer}`)
.then(res => res.json())
.then(res =>[filteredData,rawData] = [res,res])
.catch(err =>console.error(err))

function filterData() {
    const selectValue = document.querySelector("#sortBy").value
    const input = document.querySelector("#ascending").checked
    let fun

    switch(selectValue){
        case "horsepower":
            fun = input ? (a,b) => a.horsepower-b.horsepower:(a,b) => b.horsepower-a.horsepower
            filteredData = rawData.sort(fun)
        break
        case "price":
            fun = input ? (a,b) => a.price-b.price:(a,b) => b.price-a.price
            filteredData = rawData.sort(fun)
        break
    }
    
}
</script>


<main>
    <Header />

    {#if privilege=="2"}
    <div class="text-center">
       <span class="font-bold"> <p>Witaj w wypożyczalni!</p>  Wybierz auto które chcesz wypożyczyć.</span> 
        {#await result}
        <div class="text-center">
            Pobieram oferty...
        </div>
        {:then data} 
        <div class="mt-4">
            <h2 class="font-semibold">Filter</h2>
            <form on:change={filterData}>
                <select name="" id="sortBy">
                <option value="horsepower">Moc</option>
                <option value="price">Cena</option>
            </select>

            Rosnąco
            <input type="radio" name="sort" id="ascending" checked>
            Malejąco
            <input type="radio" name="sort" id="">
            </form>
        </div>
        
        <div class="flex flex-wrap mt-5 ">
            {#each filteredData as carInfo }
            <CardOffer {carInfo}/>
        {/each}
        </div>
        {/await}
    </div>
    {:else if privilege=="1"|| privilege =="3"}
        <ManagementPanel privilege={privilege}/>
    {:else}
    Strona główna :)
    {/if}
</main>

<style scoped>

</style>