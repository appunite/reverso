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

    methods: {
        saveEdit() {
            console.log("Zapis");

            //{"data":[{"name":"admin1","id":1,"email":"admin@admin.pl",
            //"crypted_password":"$2b$12$c4W9bjaWF228cu4JL1iCW.7w0ooX37lnHptqLh8OhBv5UUNJm.GS6"}]}

            /*this.$http.put('/api/accounts', jsondata).then(
                
                (response) => {
                    console.log("OK!");
                },
                (error) => {
                    alert("Oops! Something went wrong!");
                }

                /*res => {
                expect(res.ok).toBe(true);
                expect(res.status).toBe(200);
                expect(typeof res.body).toBe('string');
                expect(res.body).toBe('text');
            }*/
            
            //);
            
            //this.$router.push("/edit-profile");
        },
        cancelEdit() {
            this.$router.push("/profile");
        }
    },

    mounted() {
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