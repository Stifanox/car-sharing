<script>
import Header from "./Header.svelte";

if(sessionStorage.getItem("privilege") != "1" && sessionStorage.getItem("privilege") != "3"){
    location = "/#/accessDenied"
}

const link = "http://localhost/car-sharing/databaseCRUD.php"
const getBrandsAndPrices = "?action=getBrandsAndPrices"
const addNewOfert ="?action=addNewOffer"

let showBox = false
let success = null
const result = fetch(`${link}${getBrandsAndPrices}`)
.then(res=> res.json())

.catch(err => console.error(err))

function handleSubmit(e){
    const formData = new FormData(e.target)
    formData.set("image_source",document.querySelector("#image_file").value.split("\\")[2])

    fetch(`${link}${addNewOfert}`,{
        method:"POST",
        body:formData
    })
    .then(res => res.json())
    .then(res =>{
        success = res.success ? true:false
        showBox=true
    })
}


</script>

<main>
    <Header />
    {#await result}
        Pobieram dane...
    {:then data} 
    <div class="text-center">
        <form autocomplete="off" method="post" on:submit|preventDefault={handleSubmit}>
            <label for="brand">Marka samochodu</label>
            <select name="brand" id="brand">
                {#each data.brands as brand}
                <option value={brand.id}>{brand.brand}</option>
                {/each}
            </select>
            <label for="horsepower">Ilość koni mechanicznych</label>
            <input name="horsepower" type="number" required>
            <label for="price">Cena</label>
            <select name="price" id="price" required>
                {#each data.prices as price}
                <option value={price.id}>{price.price} zł/dzień</option>
                {/each}
            </select>
            <label for="description">Opis auta</label>
            <textarea name="description" id="" cols="50" rows="5" required></textarea>
            <label for="fuel_per_100_km">Spalanie (l/100km)</label>
            <input name="fuel_per_100_km" type="number" step="0.1" required>
            <label for="how_long_to_100">Przyśpieszenie (s/100km/h)</label>
            <input name="how_long_to_100" type="number" step="0.1"required>
            <label for="image_source">Zdjęcie</label>
            <input type="file" name="image_source" accept="image/png, image/jpeg" id="image_file" required>
            <label for="model">Model samochodu</label>
            <input type="text" name="model" required>
            <label for="body_name">Typ nadwozia</label>
            <select name="body_id" id="">
                {#each data.bodies as body}
                    <option value={body.id}>{body.body_name}</option>
                {/each}
            </select><br>
            <button type="submit" class="mt-10 mb-5">Dodaj nową ofertę samochodu</button>
        </form>
    </div>
    {/await}
    {#if showBox}
    <div class="text-center">
        {success?"Udało się dodać nową ofertę":"Nie udało się dodać nowej oferty"}
    </div>
    {/if}
    
</main>

<style scoped>

</style>