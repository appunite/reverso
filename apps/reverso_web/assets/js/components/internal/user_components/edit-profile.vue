<template>
  <div id="edit-profile" class="account">
    <el-row type="flex" class="row-bg loginPanel__row" justify="center">
      <el-col class="main-col loginPanel__main-col" :xs="16" :sm="9" :md="9" :lg="9">
        <form v-on:submit.prevent="saveEdit">
          <div class="editProfile__inputText">
            <label for="name">Name</label>
            <input type="text" v-model="data.name" id="name" class="account__input">
          </div>
          <div class="editProfile__inputText">
            <label for="email">Email Address</label>
            <input type="text" v-model="data.email" id="email" class="account__input">
          </div>
          </label>
  
          <div class="editProfile__inputText editProfile_confirmInfo">
            <label>Email address confirmation</label>
            <br>
            <p>Confirm your email address</p>
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
  name: "editProfile",

  data() {
    return {
      data: {
        id: -1,
        name: '',
        email: ''
      },

      oldData: {
        name: '',
        email: ''
      }
    }
  },

  watch: {
    name(val) {
      this.name = val;
      this.data.name = val;
    },
    email(val) {
      this.email = val;      
      this.data.email = val;
    }
  },

  methods: {
    loadSessionData() {
      var user = profileService.getProfile();
      this.data.id = user.id;
      this.data.name = user.name;
      this.data.email = user.email;

      this.oldData.name = user.name;
      this.oldData.email = user.email;

      // var address = "/api/accounts/" + this.id;
      // this.$http.get(address, {}).then(
      // (response) => {
      // this.name = response.data.data.name;
      // this.email = response.data.data.email;
      // },
      // (error) => {
      // alert("Oops! Something went wrong!");
      // }
      // )
    },

    wasChanged() {
      return (this.data.name != this.oldData.name) || (this.data.email != this.oldData.email);
    },

    saveEdit() {
      if(this.wasChanged())
      {
        var address = "/api/accounts";
        this.$http.patch(address, {
          "data" : this.data 
        }).then(
          (response) => {
            alert("ok");
          },
          (error) => {
            alert("Oops! Something went wrong!");
          }
        )

      }
      //debugger;
    }
  },

  mounted() {
    this.loadSessionData();  
  }

}
</script>

<style lang="scss">
.editProfile {

  &__save {
    width: 45%;
    margin-right: 10px;
  }

  &__cancel {
    &,
    &:link,
    &:visited,
    &:hover,
    &:active {
      background: transparent;
      color: #bbbbbb;

      display: inline-block;
      width: 45%;
      height: 35px;

      border-radius: 2px;

      font-weight: 153;
      font-size: 13px;
      text-align: center;
      text-decoration: none;
      line-height: 33px;
    }
  }

  &__inputText {
    box-sizing: border-box;
    padding: 8px;
    margin: 8px 0 8px 0;
    border: 1px solid #eee;
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