<template>

  <el-dialog
  :visible.sync="dialogData.visable"
  size="tiny"
  :before-close="handleClose"
  :show-close="false" class="reverso-dialog">
    <div slot="title" class="dialog-title">
      <icon
      v-bind:imageName="dialogData.icon_name"
      color="#969AA7">      
      </icon>
      {{ dialogData.header }}
    </div>
 
    <p class="export-info">Export file in .xliff format.</p>
    <p class="fileName">{{ dialogData.fileName }}</p>

    <div class="export-footer">
      <el-button type="primary"
      class="primary-btn"
      @click="onDownload">DOWNLOAD</el-button>

      <el-button class="cancel-btn" @click="close">Cancel</el-button>
    </div>

  </el-dialog>

</template>

<script>
import icon from "../../../../icons.vue"
export default {
  name: "exportDialog",

  props: [
    'dialogData'
  ],

  components: {
    'icon': icon
  },

  methods: {
    onDownload() {
      this.$emit('download');
      this.close();
    },

    close(){
      this.$emit("close");
    }
  }
}
</script>