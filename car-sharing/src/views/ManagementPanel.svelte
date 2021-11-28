<script>
    import AdminPanel from "../components/AdminPanel.svelte";
    import ModPanel from "../components/ModPanel.svelte"
    export let privilege
</script>

<main>
    <div class="text-center">
        <p class="font-bold">Witaj w panelu {privilege=="1"?"administatora":"moderatora"}!</p>
        <p>Co chcesz zrobić?</p>
        <div class="mt-5">
            {#if privilege == "1"}
            <div class="flex justify-around">
                <AdminPanel />
                <ModPanel />
            </div>
        {:else if privilege== "3"}
            <ModPanel />
        {/if}
        </div>
        
    </div>
</main>

<style scoped>

</style>