<script>
    export let carInfo
</script>

<div class="flex mt-20 items-center">
    <img class="flex rounded-sm ml-1" style="width: 600px; height: 460px;"  src="/img/{carInfo.image_source}" alt="Zdjęcie samochodu">
    <div class="text-center ml-20 max-w-md">
        <p>Marka: {carInfo.brand}</p> 
        <p>Moc: {carInfo.horsepower}KM</p> 
        <p>Model samochodu: {carInfo.model}</p> 
        <p>Cena: {carInfo.price} zł/dzień</p> 
        <p>Opis: {carInfo.description}</p>
        <p>Przyśpieszenie: {carInfo.how_long_to_100} s</p>
        <p>Spalanie: {carInfo.fuel_per_100_km} l/100km</p>
        <p>Typ nadwozia: {carInfo.body_name}</p>
       
    </div>
</div>
    

<style scoped>

</style>