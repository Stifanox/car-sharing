<script>
    import Header from "./Header.svelte";
    const link = "http://localhost/car-sharing/login.php"
    let displayProblem = false
    function handleSubmit(e){
        const formData = new FormData(e.target)

        fetch(link,{
            method:"POST",
            body:formData
        })
        .then(res => res.json())
        .then(res =>{
           if(res.hasOwnProperty("error")){
            displayProblem =true
           }else{
               sessionStorage.setItem("username",res.username)
               sessionStorage.setItem("id",res.id)
               sessionStorage.setItem("privilege",res.privilege)
               location = "/#/"
           }
        })
        .catch(err => console.error(err))
    }
    </script>
    
    
    <main class="h-screen">
        <Header />
        
        <div class="text-center mt-10">
            {#if displayProblem}
        <span class="text-red-500 text-center"> Nieprawidłowa nazwa użytkowanika bądź hasło. </span>
        {/if}
                <form autocomplete="off" method="post" on:submit|preventDefault={handleSubmit} >
                    <label for="username">Nazwa użytkownika</label>
                    <input class="p-1 rounded-md" type="text" name="username" id="" required>
                    <label class="mt-2" for="password">Hasło</label>
                    <input class="p-1 rounded-md" type="password" name="password" id="password" required> <br>
                    <button class="mt-5 text-white rounded button-style" type="submit">Zaloguj się</button>
                </form>
        </div>
            
    </main>
    
    <style scoped>
    .button-style{
        padding:.2em;
        background-color: var(--primary-dark);
    }
    </style>