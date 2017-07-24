<template>

  <el-dialog
  :visible.sync="dialogData.visable"
  size="tiny"
  :before-close="handleClose"
  :show-close="false" class="dialog">
    <span slot="title">
      <img :src="dialogData.icon">
      {{ dialogData.header }}
    </span>

    <el-form ref="form" :model="invitations" label-position="top">

      <div class="input-wrapper">
        <input v-model="filter" placeholder="Search">
      </div>

      <div class="invite-list">
        <el-checkbox-group v-model="invitations.invited">
          <el-checkbox-button v-for="contributor in filtered" :label="contributor.email" :name="contributor.email">
            <h4>{{contributor.email}}</h4>
            <p>{{contributor.name}}</p>
          </el-checkbox-button>
        </el-checkbox-group>
      </div>

      <div class="input-wrapper">
        <label>Send Invitation</label>
        <input type="text" v-model="invitations.inv_email" placeholder="Not listed? Invite by email address...">
      </div>

      <el-button type="primary" class="primary-btn" @click="onSubmit">save</el-button>
      <el-button class="cancel-btn" @click="dialogData.visable = false">cancel</el-button>  
    
    </el-form>
 
  </el-dialog>

</template>

<script>
export default {
  name: "contributorDialog",

  props: [
    'dialogData'
  ],

  data () {
    return {
      contributors: [],
      filter: "",
      invitations: {
        invited: [],
        inv_email: ""
      }
    }
  },
  methods: {
    onSubmit(){
    },

    fetch_users(){
      this.$http.get("/api/accounts", {}).then(
        (response) => {
          this.contributors = response.data.data;
        },
        (error) => {
          alert("Oops! Something went wrong!");
        }
      )
    }

  },
  computed: {
    filtered(){
      var filtered_tab = [];

      for (var i = 0; i < this.contributors.length; i++) { 
        if (this.contributors[i].name.toLowerCase().includes(this.filter.toLowerCase()) || this.contributors[i].email.toLowerCase().includes(this.filter.toLowerCase())){
          filtered_tab.push(this.contributors[i]);
        }
      }

      return filtered_tab;
    }
  },
  created(){
    this.fetch_users();
  }
  
}
</script>

<style scoped lang="scss">
  .invite-list {

  .el-checkbox-group {
    height: 300px;
    overflow: scroll;
    margin: 25px 0px 40px;

    .el-checkbox-button {
      width: 100%;
    }


  }

}

</style>