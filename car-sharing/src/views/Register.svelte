

<script>
import Header from "../components/Header.svelte";
const link = "http://localhost/car-sharing/register.php"
let disableButton = false
let problemOccurs = false
let notSamePasswords = false
function handleSubmit(event){
    const formData = new FormData(event.target)
    formData.append("privilege",2)
    fetch(link,{
        method:"POST",
        body:formData
    })
    .then(res => res.json())
    .then(res => {
        if(res.error){
            problemOccurs = true
        }else{
            location = "/#/"
        }
    })
    .catch(err => console.error(err))
}

function checkIfCorrentUsername(e){
    if(e.target.value.length >25){
        disableButton = true
    }else{
        disableButton = false
    }
}

function checkPassword(e){
    if(e.target.value != document.querySelector("#password").value){
        notSamePasswords = true
    }else{
        notSamePasswords = false
    }
}
</script>


<main class="h-screen">
    <Header />
    <div class="text-center mt-10">
        {#if problemOccurs}
        <span class="text-red-500">Wystąpił błąd w dodawaniu użytkownika. Konto użytkownika już istnieje lub w formularzu są zakazane znaki specjalne</span>
        {/if}
        {#if disableButton}
        <span class="text-red-500">Nazwa użytkownika nie może przekraczać 25 znaków</span>
        {/if}
        
            <form autocomplete="off" method="post" on:submit|preventDefault={handleSubmit} >
                <label for="username">Nazwa użytkownika</label>
                <input class="p-1 rounded-md" type="text" name="username" id="" on:input={checkIfCorrentUsername} required>
                <label for="email">Adres email</label>
                <input class="p-1 rounded-md" type="email" name="email" id="" required>
                <label class="mt-2" for="password">Hasło</label>
                <input class="p-1 rounded-md" type="password" name="password" id="password" required> 
                <label class="mt-2" for="password">Powtórz hasło</label>
                <input class="p-1 rounded-md" type="password" name="password" id="passwordRepeat" on:input={checkPassword} required> <br>
                {#if notSamePasswords }
                <span class="text-red-500">Hasła nie są identyczne </span> <br>
                {/if}
                <button class="mt-5 text-white rounded button-style" type="submit" disabled={disableButton||notSamePasswords}>Zarejestruj się</button>
            </form>
    </div>
        
</main>

<style scoped>
.button-style{
    padding:.2em;
    background-color: var(--primary-dark);
}
</style>