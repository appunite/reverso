<template>
  <div id="change-pass" class="changePass">
    <el-row type="flex" class="row-bg loginPanel__row" justify="center">
      <el-col class="main-col loginPanel__main-col" :xs="16" :sm="9" :md="9" :lg="9">
        <form v-on:submit.prevent="saveEdit">
          <div class="editProfile__inputText">
            <label for="currentPass">Current Password</label>
            <input type="password" v-model="passwordChangeData.currentPass" id="currentPass" class="account__input" placeholder="********" minlength="5" maxlength="30" required="required" autocomplete="off">
          </div>
          <div class="editProfile__inputText">
            <label for="newPass">New Password</label>
            <input type="password" v-model="passwordChangeData.newPass" id="newPass" class="account__input"  placeholder="********" minlength="5" maxlength="30" required="required" autocomplete="off">
          </div>
          <div class="editProfile__inputText">
            <label for="newPassConfirm">New Password (Confirmation)</label>
            <input type="password" v-model="passwordChangeData.newPassConfirm" id="newPassConfirm" class="account__input" placeholder="********" minlength="5" maxlength="30" required="required" autocomplete="off">
          </div>
          <p v-if="hasError" class="changePass__error">{{message}}</p>
          <p v-if="hasSuccess" class="changePass__success">{{message}}</p>
          <div class="account__buttonsContainer">
            <button type="submit" class="green-btn changePass__save">Save</button>
            <router-link to="/profile" class="white-btn changePass__cancel">Cancel</router-link>
          </div>
        </form>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import profileService from "../../../services/profile-service.js";
export default {
  name: "changePass",

  data() {
    return {
      hasError: false,
      hasSuccess: false,
      message: '',

      passwordChangeData: {
        id: -1,
        currentPass: '',
        newPass: '',
        newPassConfirm: ''
      }
    }
  },

  mounted() {
    var user = profileService.getProfile();
    this.passwordChangeData.id = user.id;
  },

  computed: {
    params() {
      return {
        id: this.passwordChangeData.id,
        old_password: this.passwordChangeData.currentPass,
        new_password_set: {
          password: this.passwordChangeData.newPass,
          password_confirmation: this.passwordChangeData.newPassConfirm
        } 
      }
    }
  },

  methods: {
    saveEdit() {
      profileService.changePassProfile(this.params).then(
        (response) => {
          this.message = "Your password has been changed successfully.";
          this.hasError = false;
          this.hasSuccess = true;
        },
        (error) => {
          if(error.status == 422 && this.passwordChangeData.newPass != this.passwordChangeData.newPassConfirm)
          {
            this.message = "Check passwords";
          }
          else
          {
            this.message = error.body.bodyText;
          }
          this.hasSuccess = false;
          this.hasError = true;
        }
      );
    }
  }
}
</script>

<style lang="scss">
.changePass {

  &__save {
    width: calc(50% - 14px);
    min-height: 35px;
    margin: 5px 10px 0 0;
    border-radius: 2px;
  }

  &__cancel {
    &,
    &:link,
    &:visited,
    &:hover,
    &:active {
      width: 50%;
      min-height: 35px;      
      margin: 5px 0 0 0;
      border-radius: 2px;      

      background: transparent;
      color: #bbbbbb;

      display: inline-block;

      font-weight: 153;
      font-size: 13px;
      text-align: center;
      text-decoration: none;
      line-height: 33px;
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