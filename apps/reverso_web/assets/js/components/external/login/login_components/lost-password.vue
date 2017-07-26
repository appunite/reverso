<template>
  <div id="lost-pass-box" class="lostPassBox"> 
    <div class="lostPassBox__description">
      <h3>Lost your password?</h3>
      <p>Please enter your email address. You will recieve a link to create a new password via e-mail.</p>
    </div>
    <form v-on:submit.prevent="resetPass">
      <div class="lostPassBox__inputText">
        <label for="email">Email:</label>
        <input type="email" v-model="email" id="email" class="account__input" placeholder="Email" required>
      </div>      
      <input type="submit" class="green-btn loginPanel__button" value="Reset Password">
    </form>
 </div>
</template>

<script>
import resetPasswordService from '../../../../services/reset-password-service.js';

export default {
  name: "lostPass",
  
  data() {
    return {
      email: ''
    } 
  },

  computed: {
    params() {
      return {
        email: this.email
      }
    }
  },

  methods: {
    resetPass() {
      resetPasswordService.sendResetEmailProfile(this.params).then(
        (response) => {
          this.$router.push('/reset-pass-confirm-info')
        },
        (error) => {
          alert("lostPassword: Oops! Something went wrong!");
        });
    }
  }

}
</script>

<style lang="scss">
 .lostPassBox {
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

 }
</style>