<template>
  <div id="reset-password" class="resetPassword"> 
    <div class="resetPassword__description">
      <h3>Password Reset</h3>
    </div>
    <form v-on:submit.prevent="resetPass">
      <div class="resetPassword__inputText">
        <label for="password">New Password:</label>
        <input type="password" v-model="newPassword" id="password" class="account__input" placeholder="New password" minlength="5" required>
      </div>
      <div class="resetPassword__inputText">
        <label for="password-confirm">New Password (Confirmation):</label>
        <input type="password" v-model="newPasswordConfirmation" id="password-cofirm" class="account__input" placeholder="New password (Confirmation)"  minlength="5" required>
      </div>
      <p v-if="hasError" class="resetPassword__error">{{message}}</p>
      <p v-if="hasSuccess" class="resetPassword__success">{{message}}</p>
      <input type="submit" class="green-btn loginPanel__button" value="Save Password">
    </form>
 </div>
</template>

<script>
import resetPasswordService from '../../../../services/reset-password-service.js';
import router from "../../../../routes.js";

export default {
  name: "lostPass",
  
  data() {
    return {
      hasError: false,
      hasSuccess: false,
      message: '',

      token: '',
      newPassword: '',
      newPasswordConfirmation: '',
    } 
  },

  computed:{
    params(){
      return{
        token: this.token,
        new_password: this.newPassword,
        new_password_confirmation: this.newPasswordConfirmation
      }
    }
  },

  methods: {
    onResetSuccess() {
      this.message = "Your password has been reset successfully. You will be redirected in a moment...";
      this.hasError = false;
      this.hasSuccess = true;

      setTimeout(function () {
        router.push('/');
      }, 3000);      
    },

    resetPass() {
      resetPasswordService.resetPassword(this.params).then(
        (response) => {
          this.onResetSuccess();
        },
        (error) => {
          if(error.status == 422 && this.newPassword != this.newPasswordConfirmation)
          {
            this.message = "Password confirmation is different than a password";
          }
          else
          {
            this.message = error.statusText;
          }
          this.hasSuccess = false;
          this.hasError = true;
        });
    }
  },

  mounted() {
    console.log(this.$route.query.token);
    this.token = this.$route.query.token
  }

}
</script>

<style lang="scss">
 .resetPassword {
  &__description {
    text-align: center;
  }

  &__inputText {
    box-sizing: border-box;
    padding: 8px;
    margin: 8px 0 8px 0;
    border-radius: 3px;

    label {
      color: #8E92A0;
      margin-bottom: 0;
    }

    p {
      font-size: 20px;
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