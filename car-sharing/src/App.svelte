<script>
	//TODO:zrobić protected route'y
	import RouterAdmin from "svelte-spa-router"
	import Router from "svelte-spa-router"
	import ChangePrivilege from "./views/ChangePrivilege.svelte";
	import Home from "./views/Home.svelte";
	import Login from "./views/Login.svelte";
	import NotFound from "./views/NotFound.svelte";
	import Register from "./views/Register.svelte";
	import Tailwindcss from "./Tailwindcss.svelte";
	import ChangePassword from "./views/ChangePassword.svelte";
	import ManageReservations from "./ManageReservations.svelte";
	import AddToOffer from "./views/AddToOffer.svelte";
	import MakeReservation from "./views/MakeReservation.svelte";
	import AccessDenied from "./views/AccessDenied.svelte";
	import ShowReservations from "./views/ShowReservations.svelte";
</script>

<main>
	<Tailwindcss />
	<Router 
		routes={{
			"/": Home,
            "/register":Register,
			"/login":Login,
			"/admin/addMod":ChangePrivilege,
			"/admin/changePassword":ChangePassword,
			"/admin/reservation":ManageReservations,
			"/admin/offer/add":AddToOffer,
			"/reservation/:id":MakeReservation,
			"/admin/showReservations":ShowReservations,
			"/accessDenied":AccessDenied,
			"*":NotFound
		}}
	/>

	

</main>

<style>
	@media (min-width: 640px) {
		main {
			max-width: none;
		}
	}
</style>