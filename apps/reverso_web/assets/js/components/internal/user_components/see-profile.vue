<template>
  <div id="see-profile" class="account">
    <el-row type="flex" class="row-bg loginPanel__row" justify="center">
      <el-col class="main-col loginPanel__main-col" :xs="16" :sm="9" :md="9" :lg="9">
        <form>
          <div class="account__inputText">          
            <label for="name">Name</label>
            <input type="text" v-model="name" id="name" class="account__input" readonly><br>
          </div>
          <div class="account__inputText"> 
            <label for="email">Email Address</label>
            <input type="text" v-model="email" id="email" class="account__input" readonly><br>
          </div>
          <div class="account__inputText"> 
            <label for="password">Password</label>
            <input type="password" v-model="password" class="account__input" id="password" readonly><br>
          </div>

          <div class="account__buttonsContainer">
            <button v-on:click.prevent="editProfile" class="purple-btn account__button account__editButton">Edit Profile</button>
            <button v-on:click.prevent="editPassword" class="white-btn account__button account__changePassButton">Change Password</button>
          </div>
        </form>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "seeProfile",
  
  data() {
    return {
      userId: -1,
      name: '',
      email: '',
      password: '*********'
    } 
  },

  mounted () {
      let user = JSON.parse(localStorage.getItem('currentUser'));
      this.userId = user.id; 
      this.name = user.name;
      this.email = user.email;    
  },

  methods: {
    editProfile(){
      this.$router.push("/edit-profile")
    },
    editPassword(){
      this.$router.push("/edit-pass")
    }
  }
}
</script>

<style lang="scss">
  .account {
    &__logo {
      text-align: center;
    }

    &__main-col {
      margin-top: 100px;
      padding: 15px;
      box-sizing: border-box;

      @media only screen and (max-width: 768px) {
          margin-top: 30px;
      }      
    }

    &__buttonsContainer {
      box-sizing: border-box;
      width: 100%;
    }

    &__input, &__button {
      width: 100%;       
      min-height: 35px;
      margin: 5px 0 0 0;
      border-radius: 2px;
    }

    &__button {
      width: 45%;
    }

    &__input {
      font-size: 20px;
      background: transparent;
      border: 0;
    }

    &__editButton {
      margin-right: 10px;
    }

    // &__changePassButton {
    //   @media only screen and (max-width: 460px) {
    //       position: relative;
    //       top: 12px;
    //   }    
    // }

    &__message {
      font-size: 20px;
      font-weight: 1;
      text-align: center;
      margin: 25px 0;
    }

    &__inputText {
      box-sizing: border-box;
      padding: 8px;
      margin: 8px 0 8px 0;
      border: 1px solid transparent;
      border-radius: 3px;

      label {
        color: #8E92A0;
        margin-bottom: 0;
      }
    }    
  }
</style>