<template>
  <div id="login-box" class="loginBox">

    <div class="loginPanel__message">{{ message }}</div>

    <form v-on:submit.prevent="login">
      <label for="email">Email:</label>
      <input type="text" v-model="params.email" placeholder="Email" id="email" class="loginPanel__input"><br>
      <br>
      <label for="password">Password:</label>
      <input type="password" v-model="params.password" placeholder="Password" id="password" class="loginPanel__input"><br>
      <p v-if="hasError" class="loginBox__error">{{errorMessage}}
        <router-link v-if="this.errorMessage == 'User not activated!'" to="/resend-activation" class="loginBox__error">Didn't receive activation email?</router-link>
        <router-link v-if="this.errorMessage == 'Invalid credentials!'" to="/lost-password" class="loginBox__error">Forgot password?</router-link>
      </p>
      <p v-else>&nbsp;</p>
      <br>
      <button type="submit" class="green-btn loginPanel__button">Log in</button>
      <router-link to="/sign-up" class="loginBox__transparent-btn">Sign Up</router-link>    
    </form>
 </div>
</template>

<script>
import authService from "../../../../services/auth-service.js"
import profileService from "../../../../services/profile-service"

export default {
  name: "LoginBox",
  
  data() {
    return {
      message: "It's nice to see you again!",
      errorMessage: "",
      hasError: false,
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
      authService.login(this.credentials).then(
        (response) => {
          authService.onLoginSuccess(response);
        },
        (error) => {
          this.errorMessage = error.body.error;
          this.hasError = true;
        }
      );
    }
  }

}
</script>

<style lang="scss">
  .loginBox { 
    &__transparent-btn {
      background: transparent;
      color: #bbbbbb;

      display: block;
      width: 50%;
      min-height: 35px; 

      margin: 5px auto 0 auto;
      border-radius: 2px;
      
      font-weight: 153;
      font-size: 13px;
      text-align: center;
      text-decoration: none;
      line-height: 33px;
    }

    &__transparent-btn {
      &, &:link, &:visited, &:hover, &:active {
        background: transparent;
        color: #bbbbbb;

        display: block;
        width: 50%;
        min-height: 35px; 

        margin: 5px auto 0 auto;
        border-radius: 2px;
        
        font-weight: 153;
        font-size: 13px;
        text-align: center;
        text-decoration: none;
        line-height: 33px;
      }
    }

    &__error {
        color: #fe3c5b;
       &:link, &:visited {
         text-decoration: underline;
         font-weight: 800;
         &:hover {
           color: #cb0123;
        }
      }
    }
  }
</style>
