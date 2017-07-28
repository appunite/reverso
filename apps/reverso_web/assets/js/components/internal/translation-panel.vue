<template>  
  <div class="translation-panel">
  <sidebar></sidebar>
  <translationTable></translationTable>
  </div>
</template>

<script>
import translationTable from './translation_components/translation-table.vue'
import sidebar from './translation_components/sidebar.vue'

export default {
  name: "translationPanel",

  components: {
    'translationTable': translationTable,
    'sidebar': sidebar
  },
}
  
</script>

<style lang="scss">
.translation-panel {
 display: flex;
 width: 100%;
 justify-content: space-between;
}
</style>