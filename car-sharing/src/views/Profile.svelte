<script>
    import Header from "../components/Header.svelte"
    import ReservationPreview from "../components/ReservationPreview.svelte";

    if(!sessionStorage.getItem("id")){
        location= "/#/accessDenied"
    }


    let rawData = []
    let filteredData = []
    const link = "http://localhost/car-sharing/databaseCRUD.php"
    const actionGetReservations = "?action=getAllReservationsByUserId"
    const formData = new FormData()
    formData.append("user_id",sessionStorage.getItem("id"))
    
    //pobranie czy może wypożyczać auta czy ma coś przetrzymane
    fetch(`${link}?action=doesHaveDetencion&user_id=${sessionStorage.getItem("id")}`)
    .then(res =>res.json())
    .then(res => {
        sessionStorage.setItem("detencion",res.success)
    })

    const result = fetch(`${link}${actionGetReservations}`,
    {
        method:"POST",
        body:formData
    }).then(res => res.json())
    .then(res =>{
        rawData = res
        filteredData = res.filter(el => el.status_name != "archive")
        filteredData.sort((a,b) => b.id - a.id)
        return res
    })

    function filterData(e){
        if(e.target.value != "archive") {
            filteredData = rawData.filter(el => el.status_name != "archive")
            filteredData.sort((a,b) => b.id - a.id)
        }
        else {
            filteredData = rawData.filter(el => el.status_name == "archive")
            filteredData.sort((a,b) => b.id - a.id)
        }
    }

    function removeItem(reservation_id,acception_status="canceled") {
        rawData = rawData.map(el => {
            if(el.id == reservation_id){
                el.status_name = "archive"
                el.acception_status = acception_status
                return el
            }
            else return el
        })
        filteredData = rawData.filter(el => el.status_name !="archive")
    }
</script>

<main>
    <Header/>
    <div class="w-4/5 m-auto flex justify-items-center flex-col">
        {#await result}
            <p class="text-center">Czekam na pobranie danych...</p>
        {:then reservations} 
        {#if reservations.length ==0}
           <p class="text-center">Nie masz żadnych rezerwacji. Złóż jedną aby mieć podgląd</p>
        {:else}
            <form class="flex justify-around" on:change={filterData}>
                <div>
                    Zgłoszenia aktywne: <input type="radio" name="type" value="active" id="" checked>
                </div>
                <div>
                    Zgłoszenia archiwalne: <input type="radio" name="type" value="archive" id="">
                </div>
            </form>
            {#each filteredData as reservation}
                <ReservationPreview dateEnd={reservation.date_end} dateStart={reservation.date_start} id={reservation.id} brand={reservation.brand}
                model={reservation.model} status_name={reservation.status_name} acception_status={reservation.acception_status} {removeItem} />
                
            {/each}
        {/if}
        
        {/await}
    </div>
</main>

<style scoped>

</style>