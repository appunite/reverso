<template>
  <span>
    <el-button type="text"
    class="add_sth_btn"
    id="dialogVisable"
    @click="toggleVisability">
      <img :src="dialogData.icon">Add language
    </el-button>

    <languageDialog
    v-bind:dialogData="dialogData"
    v-if="dialogData.visable"
    @close="toggleVisability">
        
    </languageDialog>
  </span>
</template>

<script>
import languageDialog from '../dialogs/language-dialog.vue'

export default {
  name: "newLanguage",

  components: {
    'languageDialog': languageDialog
  },

  data () {
    return {

      dialogData: {
        visable: false,
        header: "new language",
        icon: "/images/ic-add.svg"
      }
    }
  },

  methods: {
    toggleVisability(){
      this.dialogData.visable = !this.dialogData.visable;
    }
  }  
}
</script>