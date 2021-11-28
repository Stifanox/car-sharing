<script>

    export let carInfo
    let showTab = false
    
    window.addEventListener("resize",function () {
        console.log(window.innerWidth)
    })
</script>

<div class=" card-margin border-2 rounded border-gray-400 flex tile mt-3 h-60 box-border items-center">
    <div >
        <img class="flex rounded-sm ml-1" style="width: 300px; height: 230px;"  src="/img/{carInfo.image_source}" alt="Zdjęcie samochodu">
    </div>
        <div class="text-center m-auto">
           <p>Marka: {carInfo.brand}</p> 
           <p>Moc: {carInfo.horsepower} KM</p> 
           <p>Model samochodu: {carInfo.model}</p> 
           <p>Cena: {carInfo.price} zł/dzień</p> 
           <button on:click={()=>{showTab=true}} class="button-style text-white rounded px-1">Więcej szczegółów</button>
        </div>
</div>

{#if showTab}
<div on:click={()=>{showTab=false}} class="w-full h-full absolute bg-opacity-75 bg-gray-300 top-0 left-0"></div>

<div class="absolute rounded-md bg-white m-auto h-3/4 w-3/5 z-30 flex items-center left-1/2 transform-left">

    <img on:click={()=>{showTab=false}} src="/img/close.png" alt="" class="absolute top-0 right-0 m-1.5" style="width: 20px; cursor:pointer; height: 20px;">
<div>
    <img class="flex rounded-sm ml-1" style="width: 600px; height: 460px;"  src="/img/{carInfo.image_source}" alt="Zdjęcie samochodu">
</div>
    <div class="text-center m-auto max-w-sm">
       <p>Marka: {carInfo.brand}</p> 
       <p>Moc: {carInfo.horsepower}KM</p> 
       <p>Model samochodu: {carInfo.model}</p> 
       <p>Cena: {carInfo.price} zł/dzień</p> 
       <p>Opis: {carInfo.description}</p>
       <p>Przyśpieszenie: {carInfo.how_long_to_100} s</p>
       <p>Spalanie: {carInfo.fuel_per_100_km} l/100km</p>
       <p>Typ nadwozia: {carInfo.body_name}</p>
       <div>
            <a href="/#/reservation/{carInfo.id}"><button class="mt-3 button-style text-white rounded px-1">Złóż rezerwację</button></a> 
       </div>
    </div>
</div>
{/if}


<style scoped>
.tile{
    width: 30%;
}
.button-style{
    background-color:var(--primary-dark);
}
.card-margin{
    margin-left: 3%;
}
.transform-left{
    transform: translate(-50%,0%);
}

@media only screen and (max-width:1400px){
    .tile{
        width: 45%;
    }
    .card-margin{
        margin-left: 3%;
    }
}

@media only screen and (max-width:1068px){
    .tile{
        width: 90%;
    }
    .card-margin{
        margin-left: 5%;
    }
}
</style>