<script>
if(sessionStorage.getItem("privilege") != "1" && sessionStorage.getItem("privilege") != "3") location = "/#/accessDenied"
   import Header from "../components/Header.svelte"; 
    let showSuccess
    let actionType
   function turnScheduler(type) {
    const link = "http://localhost/car-sharing/databaseCRUD.php"
       fetch(`${link}?action=turnScheduler&type=${type}`)
       .then(res => res.json())
       .then(res =>{
           if(res.success) {
               showSuccess = true
               actionType = type =="ON"?"włączony":"wyłączony"
            }
       })
   }
</script>

<main>
    <Header />
    <div class="flex justify-around mt-3">
        <button class="button-style text-white p-1" on:click={turnScheduler.bind(this,"ON")}>Włącz scheduler</button>
        <button class="button-style text-white p-1" on:click={turnScheduler.bind(this,"OFF")}>Wyłącz scheduler</button>
    </div>
    
    {#if showSuccess}
        <p class="text-center">Scheduler został {actionType}</p>
    {/if}
</main>

<style scoped>
.button-style{
    background-color:var(--primary-dark);
}
</style>