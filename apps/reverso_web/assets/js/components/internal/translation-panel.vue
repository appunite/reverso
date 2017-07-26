<template>  
  <div class="translation-panel">
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

  data () {
    return {
      translations: [
      {
        basic: "elo",
        platform_key: "elo_k",
        description: "",
        translation: "xdxd",
        platform_id: 1
      },
      {
        basic: "elo1",
        platform_key: "elo1_k",
        description: "",
        translation: "xdxd1",
        platform_id: 1
      },
      {
        basic: "elo3",
        platform_key: "elo3_k",
        description: "",
        translation: "xdxd3",
        platform_id: 2
      },
      {
        basic: "elo4",
        platform_key: "elo4_k",
        description: "",
        translation: "xdxd4",
        platform_id: 2
      }
      ]
    }
  },
  methods: {
  }
}
  
</script>

<style lang="scss">
.translation-panel {
 display: flex;
 width: 100%;
 justify-content: space-between;
}
</style>