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
export default {
    name: "editProfile",

    data() {
        return {
            userId: 1,
            name: '',
            email: '',
            password: ''
        }
    },

    methods: {
        saveEdit() {
            console.log("Zapis");
            this.$router.push("/edit-profile");
        },
        cancelEdit() {
            this.$router.push("/profile");
        }
    },

    mounted() {
        var address = "/api/users/" + this.userId;
        console.log(address);
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