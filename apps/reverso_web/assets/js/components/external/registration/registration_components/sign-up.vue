<template>
  <div id="sign-up-box" class="signUpBox">
      <form v-on:submit.prevent="register">
        <div class="input-wrapper">
          <label for="name">Name</label>
          <input type="text" v-model="name" id="name" placeholder="Name" required>
        </div>
        <div class="input-wrapper">
          <label for="email">Email Address</label>
          <input type="email" v-model="email" id="email" placeholder="Email" required>
        </div>
        <div class="input-wrapper">
          <label for="password">Password</label>
          <input type="password" v-model="password" id="password" placeholder="Password" required>
        </div>
        <div class="input-wrapper">
          <label for="password-confirmation">Password (Confirmation)</label>
          <input type="password" v-model="passwordConfirm" id="password-confirmation" placeholder="Password (Confirmation)" required>
        </div>
        <div class="signUpBox__footer">
          <button type="submit" class="primary-btn">Sign Up</button>
          <p>By creating an account, you agree to the <a href="#">terms</a></p>
        </div>
      </form>
  </div>
</template>

<script>
import authService from "../../../../services/auth-service.js"
import profileService from "../../../../services/profile-service"

export default {
  name: "signUpBox",
  
  data() {
    return {
      name: '',
      email: '',
      password: '',
      passwordConfim: ''
    } 
  }, 

  methods: {
    register() {
      alert(this);
    }
  }
}
</script>

<style lang="scss">
  .signUpBox {
    & {
      box-shadow: 0px 0px 5px #ddd;
      margin: 20px 0 0 0;
      padding: 15px;
      border-radius: 5px;
    }

    &__footer {
      margin: 45px 0 0 0;
      text-align: center;

      p {
        margin-top: 15px;
        color: #aaa;
        font-size: smaller;
      
        a {
          &, &:link, &:visited, &:hover, &:active {
            color:inherit;
            text-decoration: underline;
          }
        }
      }
    }
  }
</style>
