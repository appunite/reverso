<template>
  <div id="edit-profile" class="account">
    <el-row type="flex" class="row-bg loginPanel__row" justify="center">
      <el-col class="main-col loginPanel__main-col" :xs="16" :sm="9" :md="9" :lg="9">
        <form v-on:submit.prevent="saveEdit">
          <div class="editProfile__inputText">
            <label for="name">Name</label>
            <input type="text" v-model="profileData.name" id="name" class="account__input" minlength="1" maxlength="30" required>
          </div>
          <div class="editProfile__inputText">
            <label for="email">Email Address</label>
            <input type="email" v-model="profileData.email" id="email" class="account__input" required>
          </div>
  
          <div v-if="showEmailConfirmationMessage" class="editProfile__inputText">
            <label>Email address confirmation</label>
            <br>
            <p>Confirm your email address</p>
          </div>
          <div v-if="showMessage" class="editProfile__inputText editProfile__green">
            <p>{{message}}</p>
          </div>
  
          <div class="account__buttonsContainer">
            <button type="submit" class="green-btn editProfile__save">Save</button>
            <router-link to="/profile" class="white-btn editProfile__cancel">Cancel</router-link>
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
      profileData: {
        id: -1,
        name: '',
        email: ''
      },

      oldProfileData: {
        id: -1,
        name: '',
        email: ''
      },

      showEmailConfirmationMessage: false,
      showMessage: false,
      message: ''
    }
  },

  computed: {
    params() {
      return { user: this.profileData }
    }
  },

  methods: {
    loadSessionData() {
      var user = profileService.getProfile();
      this.profileData = _.cloneDeep(user);
      this.oldProfileData = _.cloneDeep(user);
    },

    wasChanged() {
      return (this.profileData.name != this.oldProfileData.name)
      || (this.profileData.email != this.oldProfileData.email);
    },

    onEditSuccess() {
      if(this.profileData.email != this.oldProfileData.email)
      {
        this.showEmailConfirmationMessage = true;
      }
      profileService.setProfile(this.profileData);
      this.loadSessionData();

      this.message = "Editing completed successfully";
      this.showMessage = true;
    },

    saveEdit() {
      if (this.wasChanged()) {
        profileService.editProfile(this.params).then(
          (response) => {
            this.onEditSuccess();
          },
          (error) => {
            alert("editProfile: Oops! Something went wrong!");
          }
        )
      }
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

  &__green {
    p {
      color: green;
    }
  }
}
</style>
