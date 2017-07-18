<template>
  <div id="login-box">

    <div class="message">{{ message }}</div>

    <form v-on:submit.prevent="login">
      <label for="email">Email:</label>
      <input type="text" v-model="params.email" placeholder="Email" id="email"><br>
      <br>
      <label for="password">Password:</label>
      <input type="password" v-model="params.password" placeholder="Password" id="password"><br>
      <p v-if="wrong_pass" id="passAlert">Wrong password. <router-link to="/lost-password">Forgot password?</router-link></p>
      <br>
      <button type="submit" class="green-btn">Log in</button>
      <router-link to="/lost-password" class="white-btn">Can't log in?</router-link>
    </form>
 </div>
</template>

<script>
import authService from "../../../../services/auth-service.js";

export default {
	name: "LoginBox",
  
	data() {
		return {
      message: "It's nice to see you again!",
      wrong_pass: false,
      params:{
        email: "",
        password: ""
      }
		} 
	},

  computed: {
    credentials() {
      return {
        email: this.params.email,
        password: this.params.password
      }
    }
  },

  methods: {
    login(){
      authService.login(this, this.credentials, "/");
    }
  }

}
</script>

<style lang="scss">
  #login-box { 
    a.white-btn {
      background: transparent;
      color: #bbbbbb;

      display: block;
      width: 50%;
      height: 35px; 

      margin: 5px auto 0 auto;
      border-radius: 2px;
      
      font-weight: 153;
      font-size: 13px;
      text-align: center;
      text-decoration: none;
      line-height: 33px;
    }
  }
</style>