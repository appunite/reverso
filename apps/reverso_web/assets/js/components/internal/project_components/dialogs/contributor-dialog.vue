<template>

  <el-dialog
  :visible.sync="dialogData.visable"
  size="tiny"
  :before-close="handleClose"
  :show-close="false" class="reverso-dialog">
    <span slot="title">
      <img :src="dialogData.icon">
      {{ dialogData.header }}
    </span>

    <form ref="form" :model="invitations" label-position="top" v-on:submit.prevent="onSubmit">

      <div class="input-wrapper">
        <input v-model="filter" placeholder="Search">
      </div>

      <div class="invite-list">
        <el-checkbox-group v-model="invitations.invited">
          <el-checkbox-button          
            v-bind:key="contributor.id"
            v-for="contributor in filtered"
            :label="contributor.id"
            :name="contributor.email"            
          >
          
            <h4>{{contributor.email}}</h4>
            <p>{{contributor.name}}</p>
          </el-checkbox-button>
        </el-checkbox-group>
      </div>

      <div class="input-wrapper">
        <label>Send Invitation</label>
        <input type="email"
        v-model="invitations.inv_email"
        placeholder="Not listed? Invite by email address...">
      </div>

      <button type="submit" class="primary-btn dialog-button">save</button>
      <button type="button" class="cancel-btn dialog-button" @click="close">cancel</button>  
    
    </form>
 
  </el-dialog>

</template>

<script>
export default {
  name: "contributorDialog",

  props: [
    'dialogData',
    'projectId'
  ],

  data () {
    return {
      contributors: [],
      filter: '',
      invitations: {
        invited: [],
        inv_email: ""
      }
    }
  },

  computed: {
    filtered(){
      
      var filtered_tab = [];

      var filter = this.filter.toLowerCase();
      for (var i = 0; i < this.contributors.length-1; i++) {
        let name = this.contributors[i].name;
        let email = this.contributors[i].email;
        if(name) name = name.toLowerCase(); else name = ""; 
        if(name) email = email.toLowerCase(); else email = "";

        if ( name.includes(filter) || email.includes(filter) )
        { filtered_tab.push(this.contributors[i]); }
      }

      return filtered_tab;      
    },

    newContributors() {
      return {
        project_id: this.projectId, 
        users_ids: this.invitations.invited,
        email: this.invitations.inv_email
      }
    },

    emailInvitationParams() {
      return {
        email: this.invitations.inv_email,
        project_id: this.projectId
      }
    }
  },

  methods: {
    onSubmit(){
      if(this.invitations.invited.length > 0)
      {
        this.submitNewContributors();
      }
      
      if(this.invitations.inv_email != "")
      {
        this.submitInviteContributors();
      }
    },

    submitNewContributors(){
      this.$http.post("/api/collaborators", this.newContributors ).then(
        (response) => {
          this.openSuccessMessage("Contributors added");
          this.close();
        },
        (error) => {
          this.openErrorMessage("Oops! Something went wrong!");          
        }
      );
    },

    submitInviteContributors(){
      this.$http.post("/api/invitation/new", this.emailInvitationParams ).then(
        (response) => {
          this.openSuccessMessage("Invitation sent");
          this.close();
        },
        (error) => {
          this.openErrorMessage("Invitation error");  
        }
      );
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
    },

    openSuccessMessage(text) {
      this.$message({
        showClose: true,
        message: text,
        type: 'success'
      });
    },  

    openErrorMessage(text) {
      this.$message({
        showClose: true,
        message: text,
        type: 'error'
      });
    },  

    close(){
      this.$emit("close");
    }

  },

  mounted(){
    this.fetch_users();
  }
  
}
</script>
