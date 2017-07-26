<template>
  <div id="reset-password" class="resetPassword"> 
    <div class="resetPassword__description">
      <h3>Password Reset</h3>
    </div>
    <form v-on:submit.prevent="resetPass">
      <div class="resetPassword__inputText">
        <label for="password">New Password:</label>
        <input type="password" v-model="newPassword" id="password" class="account__input" placeholder="New password" required>
      </div>
      <div class="resetPassword__inputText">
        <label for="password-confirm">New Password (Confirmation):</label>
        <input type="password" v-model="newPasswordConfirm" id="password-cofirm" class="account__input" placeholder="New password (Confirmation)" required>
      </div> 
      <input type="submit" class="green-btn loginPanel__button" value="Save Password">
    </form>
 </div>
</template>

<script>
export default {
  name: "lostPass",
  
  data() {
    return {
      token: '',
      newPassword: '',
      newPasswordConfirmation: '',
    } 
  },

  computed:{
    params(){
      return{
        passReset : {
          token: this.token,
          new_password: this.newPassword,
          new_password_confirmation: this.new_password_confirmation
        }
      }
    }
  },

  methods: {
    resetPass() {
      Vue.$http.post("/api/resetpassword", params).then(
        (response) => {
          ;
        },
        (error) => {
          ;// error callback
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

 }
</style>