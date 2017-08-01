<template>
  <div id="sign-up-box" class="signUpBox">
      <form v-on:submit.prevent="register">
        <div class="input-wrapper">
          <label for="name">Name</label>
          <input type="text" v-model="name" id="name" placeholder="Name" required>
        </div>
        <div class="input-wrapper">
          <label for="email">Email Address</label>
          <input type="email" v-model="email" id="email" placeholder="Email" :readonly="isInvited" required>
        </div>
        <div class="input-wrapper">
          <label for="password">Password</label>
          <input type="password" v-model="password" id="password" placeholder="Password" required>
        </div>
        <div class="input-wrapper">
          <label for="password-confirmation">Password (Confirmation)</label>
          <input type="password" v-model="passwordConfirm" id="password-confirmation" placeholder="Password (Confirmation)" required>
        </div>
        <p v-if="hasError" class="signUpBox__error">{{message}}</p>
        <p v-if="hasSuccess" class="signUpBox__success">{{message}}</p>
        <div class="signUpBox__footer">
          <button type="submit" class="primary-btn">Sign Up</button>
          <p>By creating an account, you agree to the <a href="#">terms</a></p>
        </div>

        {{email}} / {{invitation_token}} / {{project_id}} / {{isInvited}}  
      </form>
  </div>
</template>

<script>
import router from "../../../../routes.js";
import authService from "../../../../services/auth-service.js"
import profileService from "../../../../services/profile-service.js"

export default {
  name: "signUpBox",
  
  data() {
    return {
      hasError: false,
      hasSuccess: false,
      message: '',

      name: '',
      email: this.$route.query.email || "",
      password: '',
      passwordConfirm: '',

      isInvited: false,

      invitation_token: this.$route.query.invitation_token || "",
      project_id: this.$route.query.project_id || ""
    } 
  }, 

  computed: {
    newUserParams() {
      return {
        user: {
          email: this.email,
          name: this.name,
          password: this.password,
          password_confirmation: this.passwordConfirm
        }
      }
    },
    activateInviationParams() {
      return {
        user: {
          email: this.email,
          name: this.name,
          password: this.password,
          password_confirmation: this.passwordConfirm
        },
        invitation_token: this.invitation_token,
        project_id: this.project_id     
      }
    }
  },

  mounted() {
    this.checkInvitation();
  },

  methods: {
    register() {
      if(this.isInvited)
      {
        this.registerInvited();
      }
      else
      {
        this.registerNew();
      }
    },

    registerNew() {
      profileService.registerUser(this.newUserParams).then(
        (response) => {
          this.$router.push("/new-user-box");
          this.hasError = false;
          this.hasSuccess = true;
        },
        (error) => {
          if(error.body.error) {
            this.message = error.body.error;
          } else {
            this.message = error.body.bodyText;
          }
          this.hasSuccess = false;
          this.hasError = true;
        }
      );
    },

    registerInvited() {
      profileService.activateInvitedUser(this.activateInviationParams).then(
        (response) => {
          this.$router.push("/new-user-box");
          this.hasError = false;
          this.hasSuccess = true;
        },
        (error) => {
          if(error.body.error) {
            this.message = error.body.error;
          } else {
            this.message = error.body.bodyText;
          }
          this.hasSuccess = false;
          this.hasError = true;
        }
      );
    },

    checkInvitation() {
      if(typeof this.invitation_token !== 'undefinied' && this.invitation_token != '')
      {
        this.isInvited = true;
      }
      else
      {
        this.isInvited = false;
      }      

      if(this.isInvited && (typeof this.email !== 'undefinied' && this.email != ''))
      {
        ;      
      }
      else
      {
        this.isInvited = false;
      }

      if(this.isInvited && (typeof this.project_id !== 'undefinied' && this.project_id != ''))
      {
        ;
      }
      else
      { 
        this.isInvited = false;
      }    
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

    &__error {
      color: #fe3c5b;
    }

    &__success {
      color: #38c885;
    }  
  }
</style>
