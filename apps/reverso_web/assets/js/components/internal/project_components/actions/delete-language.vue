<template>
<span>
  <el-button  class="delete-btn" @click="toggleVisibility">
    <slot>
      Delete
    </slot>
  </el-button>  
  
  <deleteDialog 
  v-bind:dialogData="dialogData"
  v-if="dialogData.visable" 
  v-on:confirm="deleteLanguage"
  @close="toggleVisibility">
      
  </deleteDialog>
</span>
</template>

<script>
import languageService from '../../../../services/language-service.js'
import deleteDialog from '../dialogs/delete-dialog.vue'

export default {
  name: "deleteLanguage",

  props: [
    'language_id'
  ],

  components: {
    'deleteDialog': deleteDialog
  },

  data () {
    return {
      dialogData: {
        visable: false,
        deletionObject: "language"
      }
    }
  },

  methods: {
    deleteLanguage(){
      languageService.deleteLanguageFromProject(this.language_id).then(
          (response) => {
            this.$router.push('/projects');
            this.$message({
              message: 'Delete completed.',
              type: 'success'
            });
          },
          
          (error) =>{
            console.log(error);
          }
        );
    },

    toggleVisibility(){
      this.dialogData.visable = !this.dialogData.visable;
    }
  }
}
</script>
