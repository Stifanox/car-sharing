<script>
import Header from "../components/Header.svelte";

if(sessionStorage.getItem("privilege") != "1"){
    location = "/#/accessDenied"
}

const link = "http://localhost/car-sharing/databaseCRUD.php"
const getAllUsers = "?action=getAllUsers"
const actionChangePassword = "?action=changePassword"

let showBox = false
    let lastID = 0
    let success = null

async function getListOfUsers(){
        const res = await fetch(`${link}${getAllUsers}`)
        const data = await res.json()

        if(res.ok){
            return data.filter(el => el.username !="admin")
        }else{
            throw new Error("Coś poszło nie tak")
        }
    }

    const listOfUsers = getListOfUsers()
    function changePassword(id){
    if(document.querySelector(`#u${id}`).value.length <= 0) {
        alert("Hasło musi mieć minimum 1 znak")
        return
    }
        const formData = new FormData()
        formData.append("id",id)
        formData.append("password",document.querySelector(`#u${id}`).value)
        
        fetch(`${link}${actionChangePassword}`,{
            body:formData,
            method:"POST"
        }).then(res => res.json())
        .then(res => {
            success = res.success ? true:false
            lastID = id
            showBox = true
        })
        .catch(err =>console.error(err))
    }

   
</script>

<main>
    <Header />

{#await listOfUsers}
    Pobieranie listy użytkowników...
{:then users} 
    <div class="flex justify-center">
        <table >
            <thead>
                <tr>
                    <th class="px-10">ID</th>
                    <th>Nazwa użytkownika</th>
                    <th>Nowe hasło</th>
                </tr>
            </thead>
            <tbody>
                {#each users as user}
                <tr class="text-center">
                    <td>{user.id}</td>
                    <td>{user.username}</td> 
                    <input type="password" name="password" id={"u"+user.id}>
                    
                    <td><button class="mx-2 px-2 text-white rounded button-style" on:click={changePassword.bind(this,user.id)}>Zmień hasło</button></td>
                </tr>
                {/each}
            </tbody>
        </table>
    </div>
    {#if showBox}
        <div class="text-center">
            Użytkownik o id:{lastID} {success?"":"nie"} został zaktualizowany
        </div>
        {/if}
{/await}
</main>

<style scoped>
.button-style{
    background-color: var(--primary-dark);
}
</style>