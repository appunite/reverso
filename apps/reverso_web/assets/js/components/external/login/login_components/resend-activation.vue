<template>
  <div id="lost-pass-box" class="lostPassBox"> 
    <div class="lostPassBox__description">
      <h3>Didn't get activation email?</h3>
      <p>Please enter your email address.<br> You will recieve another activation email.</p>
    </div>
    <form v-on:submit.prevent="resendActivation">
      <div class="lostPassBox__inputText">
        <label for="email">Email:</label>
        <input type="email" v-model="email" id="email" class="account__input" placeholder="Email" required>
      </div>      
      <input type="submit" class="green-btn loginPanel__button" value="Reset Password">
    </form>
 </div>
</template>

<script>
import resendActivationService from '../../../../services/resend-activation-service.js';

export default {
  name: "resendActivation",
  
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
    resendActivation() {
      resendActivationService.resendActivation(this.params).then(
        (response) => {
          this.$router.push("/new-user-box");
        },
        (error) => {
          alert("resendActivation: Oops! Something went wrong!");
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
