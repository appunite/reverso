<template>
  <span>
    <el-button type="text" id="dialogVisable"  @click="dialogData.visable = true">
      <img :src="dialogData.icon">Add language
    </el-button>
    <languageDialog v-bind:dialogData="dialogData" v-if="dialogData.visable" @close="dialogData.visable = false">
        
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

  }
  
}
</script>