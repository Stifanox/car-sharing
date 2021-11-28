<script>
import CarDetail from "../components/CarDetail.svelte";
import ReservationForm from "../components/ReservationForm.svelte";
import Header from "./Header.svelte";
    export let params 

    if(!sessionStorage.getItem("privilege")){
    location = "/#/accessDenied"
    }

    const link = "http://localhost/car-sharing/databaseCRUD.php"
    const actionGetOfferById = "?action=getOfferById"
    const actionGetOfferStatus = "?action=getOfferStatus&id=" + params.id
    const actionMakeReservation = "?action=makeReservation"
    const date = new Date(Date.now())

    const formData = new FormData()
    formData.append("id",params.id)
    const result = fetch(`${link}${actionGetOfferById}`,{
        method:"POST",
        body:formData
    }).then(res => res.json())

    const carStatus = fetch(`${link}${actionGetOfferStatus}`,{
        method:"GET"
    }).then(res => res.json())

    function getFormattedDate(date) {
        return `${date.getFullYear()}-${date.getMonth()+1}-${date.getDate()}`
    }

    function doReservation(event) {
        const formDataReservation = new FormData()
        formDataReservation.append("user_id",sessionStorage.getItem("id"))
        formDataReservation.append("offer_id",params.id)
        formDataReservation.append("date_start",event.detail.startDate)
        formDataReservation.append("date_end",event.detail.endDate)
        formDataReservation.append("status_id",3)
        fetch(`${link}${actionMakeReservation}`,{
            method:"POST",
            body:formDataReservation
        }).then(res => res.json())
        .then(res => console.log(res.success))
    }
</script>

<main>
<Header/>
    {#await result}
        Pobieranie informacji...
    {:then carInfo} 
        {#if carInfo.length == 0}
            Niepoprawne id
        {:else}
        <div class="flex items-center justify-around">
            <CarDetail carInfo={carInfo[0]}/>
            {#await carStatus}
                Pobieram status...
            {:then carStatus} 
                {#if carStatus.length==0}
                    Status: dostępny
                    <ReservationForm on:dates={doReservation} {getFormattedDate} {date}/>
                {:else if carStatus[0].status_name=="not_available"}
                    Status: niedostępny
                {:else if carStatus[0].status_name=="waiting"}
                    Status: oczekujący
                    <ReservationForm on:dates={doReservation} {getFormattedDate} {date}/>
                {:else if carStatus[0].status_name=="accepted"}
                Status: niedostępny
                {/if}
            {/await}
        </div>
        {/if}
    {/await}
</main>

<style scoped>

</style>
