<template>
<span>
    <button id="show-modal" @click="showModal = true">Add new project</button>
    <modalBox v-if="showModal" @close="showModal = false">
        
    </modalBox>
</span>
</template>

<script>
import modalBox from '../session_components/modals/modal-box.vue'

export default {
  name: "newProject",

  components: {
    'modalBox': modalBox
  },

  data () {
    return {
      showModal: false
    }
  }
}
</script>