<template>
  <div id="login-box">

    <div class="message">{{ message }}</div>

    <form v-on:submit.prevent="login">

      <label for="email">Email:</label>
      <input type="text" v-model="params.user.email" placeholder="Email" id="email"><br>
      <br>
      <label for="password">Password:</label>
      <input type="password" v-model="params.user.password" placeholder="Password" id="password"><br>
      <p v-if="wrong_pass" id="passAlert">Wrong password. <router-link to="/lost-password">Forgot password?</router-link></p>
      <br>
      <button type="submit" class="green-btn">Log in</button>
      <router-link to="" class="white-btn">Can't log in?</router-link>
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
    }
  }

}
</script>

<style>
  #login-box a.white-btn {
    background: transparent;
    color: #bbbbbb;

    display: block;
    width: 100%;
    height: 35px; 

    margin: 5px 0 0 0;
    border: 1px red solid;
    border-radius: 2px;
    
    font-weight: 153;
    font-size: 13px;
    text-align: center;
    text-decoration: none;
    line-height: 33px;
  }

</style>

