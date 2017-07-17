<template>
  <div id="login-box">

    <h3>{{ message }}</h3>

    <form>

      Email:<br>
      <input type="text" v-model="params.user.email" placeholder="Email"><br>
      {{params.user.email}}
      Password:<br>
      <input type="password" v-model="params.user.password" placeholder="Password"><br>
      {{params.user.password}}
      <p v-if="wrong_pass" id="passAlert">Wrong password. <router-link to="/lost-password">Forgot password?</router-link></p>

      <button v-on:click.prevent="login">Log in</button>
      <button v-on:click.prevent="lostPass">Can't log in?</button>
    </form>
 </div>
</template>

<script>
export default {
	name: "LoginBox",
  
	data() {
		return {
      message: "It's nice to see you again!",
      wrong_pass: false,
      params:{
        user:{
          email: "",
          password: ""
        }
      }
		} 
	},

  methods: {
    login(){
      this.$http.post("/api/login/", {
        params: this.params
      }).then(
        (response) => {
          console.log(response);
        },
        (error) => {
          alert("Oops! Something went wrong!");
        }
      )
    },

    lostPass(){
      this.$router.push("/lost-password");
    }
    
  }

}
</script>

<style>
/*
  #login-box {
    border: solid;
    margin-top: 20px;
  }
  

  #lostPassMild {
    color: lightgray;
  }

  #passAlert {  
    color: red;
    text-align: left;
  }
*/
</style>

