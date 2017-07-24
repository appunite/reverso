<template>
  <div id="edit-profile" class="account">
    <el-row type="flex" class="row-bg loginPanel__row" justify="center">
      <el-col class="main-col loginPanel__main-col" :xs="16" :sm="9" :md="9" :lg="9">
        <form v-on:submit.prevent="saveEdit">
          <div class="editProfile__inputText">
            <label for="currentPass">Current Password</label>
            <input type="password" v-model="data.currentPass" id="currentPass" class="account__input" placeholder="********" minlength="5" maxlength="30" required="required" autocomplete="off">
          </div>
          <div class="editProfile__inputText">
            <label for="newPass">New Password</label>
            <input type="password" v-model="data.newPass" id="newPass" class="account__input"  placeholder="********" minlength="5" maxlength="30" required="required" autocomplete="off">
          </div>
          <div class="editProfile__inputText">
            <label for="newPassConfirm">New Password (Confirmation)</label>
            <input type="password" v-model="data.newPassConfirm" id="newPassConfirm" class="account__input" placeholder="********" minlength="5" maxlength="30" required="required" autocomplete="off">
          </div>
  
          <div class="account__buttonsContainer">
            <button type="submit" class="green-btn account__button editProfile__save">Save</button>
            <router-link to="/profile" class="white-btn account__button editProfile__cancel">Cancel</router-link>
          </div>
        </form>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import profileService from "../../../services/profile-service.js"
export default {
  name: "changePass",

  data() {
    return {
      data: {
        id: -1,
        currentPass: '',
        newPass: '',
        newPassConfirm: ''
      }
    }
  },

  mounted () {
    var user = profileService.getProfile();
    this.data.id = user.id;
  },

  methods: {
    saveEdit() {
        var address = "/api/accounts/" + this.data.id;
        this.$http.patch(address, {
          "user": {
            
          }
        }).then(
          (response) => {
            alert('ok');
          },
          (error) => {
            alert("editProfile: Oops! Something went wrong!");
          }
        );
    }
  }
}
</script>

<style>
</style>