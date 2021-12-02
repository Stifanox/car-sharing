<script>
    import { createEventDispatcher } from 'svelte';

    const dispatch = createEventDispatcher()
    let showProblemBlock = false
    function callParent(e) {
        if(e.target.elements[0].valueAsNumber >= e.target.elements[1].valueAsNumber){
            showProblemBlock = true
            return
        }
        const startDate = e.target.elements[0].value
        const endDate = e.target.elements[1].value
        dispatch("dates",{
            startDate:startDate,
            endDate:endDate
        })
    }
    export let getFormattedDate
    export let date
    export let doesMadeReservation
</script>

<div class="text-center max-w-sm">
    <form  on:submit|preventDefault={callParent}>
        <label for="reservation_date_start">Rozpoczęcie wypożyczenia</label>
        <input type="date" name="reservation_date_start" value={getFormattedDate(date)} min={getFormattedDate(date)} >
        <label for="reservation_date_start">Zakończenie wypożyczenia</label>
        <input type="date" class="mb-5" name="reservation_date_end" value={getFormattedDate(date)} min={getFormattedDate(date)} ><br>
        <button type="submit" class="button-style text-white rounded px-1" disabled={doesMadeReservation} >Zarezerwuj</button>
        
    </form>
    {#if doesMadeReservation}
    <p class="text-red-600">Złożono już rezerwację przez ciebie na to auto. Jeżeli chcesz złożyć rezerwację na to auto to odwołaj poprzednią i złóż nową</p>
    {/if}
    {#if showProblemBlock}
        <p class="text-red-600">Daty muszą być różne lub data rozpoczęcia jest przed datą zakończenia</p>
    {/if}
</div>

<style scoped>
    .button-style{
    background-color:var(--primary-dark);
}
</style>