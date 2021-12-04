<script>
export let brand
export let model
export let status_name
export let acception_status
export let removeItem
export let id
export let offerId = 0
export let userId = 0
export let userName = ""
export let dateStart
export let dateEnd
import QRCode from "svelte-qrcode"


const privilege = sessionStorage.getItem("privilege");
const link = "http://localhost/car-sharing/databaseCRUD.php"
const actionCancelBooking = "?action=cancelBooking"
const actionReturnCar= "?action=returnCar"
const actionAcceptBooking = "?action=acceptBooking"
const actionChangeDate = "?action=changeDate"

let displayChangeDateForm = false
let displayDateChanged = false
function cancelBooking() {
    const formData = new FormData()
    formData.append("reservation_id",id)
    
    fetch(`${link}${actionCancelBooking}`,{
        method:"POST",
        body: formData
    })
    .then(res => res.json())
    .then(res => {
        if(res.success){
            if(acception_status == "detencion") removeItem(id,"detencion")
            else removeItem(id)
        }
    })

}


function acceptBooking() {
    const formData = new FormData()
    
    formData.append("offer_id",offerId)
    formData.append("user_id",userId)
    fetch(`${link}${actionAcceptBooking}`,{
        method:"POST",
        body: formData
    })
    .then(res =>res.json())
    .then(res => {
        if(res.success) location.reload()
    })

}

function returnCar() {
    const formData = new FormData()
    formData.append("reservation_id",id)
    formData.append("acception_status",acception_status)
    
    fetch(`${link}${actionReturnCar}`,{
        method:"POST",
        body: formData
    })
    .then(res => res.json())
    .then(res => {
        if(acception_status == "detencion") removeItem(id,"detencion")
        else removeItem(id)
    })
}

function changeDateOfReservation(e) {
    if(e.target.elements[0].value > e.target.elements[1].value ) return
    const formData = new FormData(e.target)

    formData.append("reservation_id",id)
    fetch(`${link}${actionChangeDate}`,
    {
        method:"POST",
        body:formData
    })
    .then(res =>res.json())
    .then(res => displayDateChanged = true)
}

function doesDateStart() {
    const startDate = new Date(`${dateStart} 00:00:00`)
    const dateNow = Date.now()
    console.log(startDate.valueOf() < dateNow , startDate.valueOf(),dateNow)
    return startDate.valueOf() < dateNow
}

function getToday() {
    const date = new Date()
    const month = date.getMonth()+1 < 9 ? `0${date.getMonth()+1}`:date.getMonth()+1
    const day = date.getDate() < 9 ? `0${date.getDate()}`:date.getDate()
    return `${date.getFullYear()}-${month}-${day}`
}
</script>

<main class="border-4 rounded-md border-blue-500 mt-3 p-3 flex justify-around"
    class:rejected={acception_status=="rejected"}
    class:accepted={acception_status=="accepted"}
    class:waiting={acception_status=="waiting"}
    class:canceled={acception_status=="canceled"}
    class:returned={acception_status=="returned"}
    class:detencion={acception_status=="detencion"}
>

    <div class="self-center">
        {#if privilege!=2}
        <p>Id zgłoszenia: {id}</p>
        <p>Nazwa użytkownika: {userName}</p>
    {/if}
    <p>Start wypożyczenie: {dateStart}</p>
    <p>Koniec wypożyczenie: {dateEnd}</p>
    <p>Marka samochodu: {brand}</p>
    <p>Model samochodu: {model}</p>
    <p>Status oferty: {status_name}</p>
    <p>Status rezerwacji: {acception_status}</p>
    </div>
    

    {#if privilege==2}
        {#if status_name =="waiting"}
            <button on:click={cancelBooking} class="button-style text-white p-1 rounded-md border-2 self-center">Odwołaj rezerwację</button>
        {:else if status_name=="not_available" && (acception_status=="accepted"||acception_status=="detencion" )}
        
            {#if doesDateStart()}
                <div class="w-15 h-15">
                    <QRCode value={`${id}-${brand}-${model}`} />
                </div>
            {/if}
        
            <button on:click={returnCar} class="button-style text-white p-1 rounded-md border-2 self-center">Zwróć samochód</button>
        {/if} 
        
    {:else}
        {#if status_name =="waiting"}
            <button on:click={acceptBooking} class="button-style text-white p-1 rounded-md border-2 self-center">Akceptuj rezerwację</button>
        {:else if status_name =="not_available"}
            <button on:click={() => displayChangeDateForm = !displayChangeDateForm} class="button-style text-white p-1 rounded-md border-2 self-center ">Zmień datę wypożyczenie</button>
            
            {#if displayChangeDateForm}
            <div class="self-center max-w-sm">
                <form class="flex flex-col" on:submit|preventDefault={changeDateOfReservation}>
                    <div class="self-center">
                        <div class="mr-3">
                            <label for="date_start">Data rozpoczęcia</label>
                            <input type="date" name="date_start" id="" value={dateStart} min={getToday()}>
                        </div>
                        <div>
                            <label for="date_start">Data zakończenia</label>
                            <input type="date" name="date_end" id="" value={dateEnd} min={dateStart}>
                        </div>
                    </div>
                    
                    <button type="submit" class="button-style text-white px-1 rounded-md border-2 mt-2 self-center ">Zmień date</button>
                    {#if displayDateChanged}
                        Data rezerwacji została zmieniona
                    {/if}
                   </form>
            </div>               
            {/if}

        {/if}
    {/if}

   
</main>

<style scoped>
.accepted{
    background-color: rgba(110, 231, 183,1)
}
.rejected{
    background-color: rgba(252, 165, 165,1)
}
.waiting{
    background-color: rgba(252, 211, 77,1)
}
.canceled{
    background-color: var(--secondary-dark)
}
.returned{
    background-color: rgb(77, 232, 252)
}
.detencion{
    background-color: rgb(255, 109, 236)
}
.button-style{
    background-color:var(--primary-dark);
}
</style>