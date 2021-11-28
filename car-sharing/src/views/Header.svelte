<script>
    const username = sessionStorage.getItem("username")
    function logout(){
        sessionStorage.clear()
        if(location.hash == "#/") location.reload()
    }
</script>

<header class="flex header-styles color-primary h-12 p-2">
    <a href="/#/" class="link-styles align-links">
    <div >
        <img src="img/icon.svg" width="100px" class="inline" alt="Hejo">
        Uga buga wypożyczalnia samochodów
    </div>
    </a>
    {#if username}
    <div class="align-links">
        <a class="mr-5" href="/#/profile">Profil</a>
        <a href="/#/" on:click={logout}>Wyloguj</a>
    </div>  
    {:else}
    <div class="align-links">
        <a class="mr-5" href="/#/register">Rejestracja</a>
        <a href="/#/login">Logowanie</a>
    </div> 
    {/if}
</header>

<style>
.align-links{
    align-self: center;
}
.header-styles{
    justify-content: space-between;
}
.link-styles:hover{
    text-decoration: none;
}
.link-styles:visited{
    color:#333;
}
.color-primary{
    background-color: var(--primary);
}
</style>