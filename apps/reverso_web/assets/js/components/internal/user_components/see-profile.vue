<template>
  <div id="see-profile" class="account">
    <el-row type="flex" class="row-bg loginPanel__row" justify="center">
      <el-col class="main-col loginPanel__main-col" :xs="16" :sm="9" :md="9" :lg="9">
				<form>
					<label for="name">Name</label>
					<input type="text" v-model="name" id="name" class="account__input" readonly><br>
					<label for="email">Email Address</label>
					<input type="text" v-model="email" id="email" class="account__input" readonly><br>
					<label for="password">Password</label>
					<input type="password" v-model="password" class="account__input" id="password" readonly><br>
					
					<button v-on:click.prevent="editProfile" class="purple-btn account__button">Edit Profile</button>&nbsp;
					<button v-on:click.prevent="editPassword" class="white-btn account__button">Change Password</button>
					
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

    &__input, &__button {
      background: transparent;
      width: 100%;       
      height: 35px;
      margin: 5px 0 0 0;
      border: 0;
      border-radius: 2px;
    }

    &__input {
      font-size: 20px;
    }

    &__message {
      font-size: 20px;
      font-weight: 1;
      text-align: center;
      margin: 25px 0;
    }    

  }
</style>