<template>
    <div id="account-box">
    
        <form>
            Name
            <br>
            <input type="text" v-model="name">
            <br> Email Address
            <br>
            <input type="text" v-model="email">
            <br> 
            Email address confirmation<br>Confirm your email address
            <br>
    
            <button v-on:click.prevent="saveEdit">Save</button>&nbsp;
            <button v-on:click.prevent="cancelEdit">Cancel</button>
    
        </form>
    </div>
</template>

<script>
import profileService from "../../../services/profile-service.js"
export default {
    name: "editProfile",

    data() {
        return {
            userId: 1,
            name: '',
            email: '',
            password: '',
            
            data:{
                name: '',
                id: '',
                email: '',
                crypted_password: ''
            }
        }
    },

    watch() {
            this.data.name = this.name;
            this.data.id = this.userId;
            this.data.email = this.email;
            this.data.crypted_password = this.password;
    },

    methods: {},

    mounted() {
        var user = profileService.getProfile();
       // debugger;
        console.log(user);
        this.userId = user.id;

        var address = "/api/accounts/" + this.userId;

        this.$http.get(address, {}).then(
            (response) => {
                this.name = response.data.data.name;
                this.email = response.data.data.email;
            },
            (error) => {
                alert("Oops! Something went wrong!");
            }
        )
    }

}
</script>

<style>

</style>