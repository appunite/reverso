<template>

  <el-dialog
  :visible.sync="dialogData.visable"
  size="tiny"
  :before-close="handleClose"
  :show-close="false">
    <span slot="title" class="dialog-title">
      <img :src="dialogData.icon">
      {{ dialogData.header }}
    </span>

    <el-form ref="form" :model="invitations" label-position="top">

      <el-input v-model="filter" placeholder="Search"></el-input>

      <el-checkbox-group v-model="invitations.invited">
        <el-checkbox-button v-for="contributor in filtered" :label="contributor.name" :name="contributor.email" style="width: 100%;">
        {{contributor.email}}<br />
        {{contributor.name}}
        </el-checkbox-button>
      </el-checkbox-group>

      <el-form-item label="Send Invitation">
        <el-input v-model="invitations.inv_email" placeholder="Not listed? Invite by email address..."></el-input>
      </el-form-item>

      <el-button type="primary" @click="onSubmit">save</el-button>
      <el-button @click="dialogData.visable = false">cancel</el-button>  

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
      contributors: [
        {name: "Uzumaki Naruto", email: "uzumaki@elo.pl"},
        {name: "Uchiha Sasuke", email: "uchiha@elo.pl"},
        {name: "Sakura Chan", email: "sakurka@elo.pl"}
      ],
      filter: "",
      invitations: {
        invited: [],
        inv_email: ""
      }
    }
  },
  methods: {
    onSubmit(){

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
  }
  
}
</script>


