<script>
import Header from "../components/Header.svelte";

if(sessionStorage.getItem("privilege") != "1"){
    location = "/#/accessDenied"
}

const link = "http://localhost/car-sharing/databaseCRUD.php"
const getAllUsers = "?action=getAllUsers"
const updatePrivilege = "?action=changePrivilege"

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

    let listOfUsers = getListOfUsers()

    function changePrivilege(id){
        const formData = new FormData()
        formData.append("id",id)
        formData.append("privilege_id",document.querySelector(`#u${id}`).value == "user" ? "2":"3")
        fetch(`${link}${updatePrivilege}`,{
            method:"POST",
            body:formData
        })
        .then(res => res.json())
        .then(res =>{            
            success = res.success ? true:false
            showBox = true
            lastID = id
        })
        .catch(err => console.error(err))
    }

</script>

<main>
    <Header />
    {#await listOfUsers}
    <div class="text-center">
        Pobieram dane o użytkownikach...
    </div>
    {:then data} 
    <div class="flex justify-center">
        <table >
            <thead>
                <tr>
                    <th class="px-10">ID</th>
                    <th>Nazwa użytkownika</th>
                    <th class="px-10">Email</th>
                    <th>Uprawnienia</th>
                </tr>
            </thead>
            <tbody>
                {#each data as user}
                <tr class="text-center">
                    <td>{user.id}</td>
                    <td>{user.username}</td> 
                    <td>{user.email}</td>
                    <td>
                        <select id={"u"+user.id} class="text-center" bind:value={user.role_name}>
                            <option value="user">User</option>
                            <option value="moderator">Moderator</option>
                        </select>
                    </td>
                    <td><button class="mx-2 px-2 text-white rounded button-style" on:click={changePrivilege.bind(this,user.id)}>Zmień role</button></td>
                </tr>
                {/each}
            </tbody>
        </table>
    </div>
    {:catch error}
        {error.message}
    {/await}
    {#if showBox}
    <div class="text-center">
        Użytkownik o id: {lastID} {success? "":"nie"} został zaktualizowany.
    </div>
    {/if}
</main>

<style scoped>
.button-style{
    background-color: var(--primary-dark);
}
</style>